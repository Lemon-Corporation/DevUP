from fastapi import APIRouter, Depends, HTTPException, Request, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.auth import get_current_admin
from app.schemas.stats import GlobalStats
from app.services.stats_service import count_online, recalculate_stats

router = APIRouter()


@router.get("/admin/app_activity", response_model=GlobalStats)
async def app_activity(
    request: Request,
    current_admin=Depends(get_current_admin),
    session: AsyncSession = Depends(lambda: request.app.state.db_session),
    redis=Depends(lambda: request.app.state.redis_client),
):
    """Статистика приложения для админа."""
    try:
        data = await redis.hgetall("stats:global")
    except Exception:
        data = {}
    if data:
        active = await count_online(redis)
        return GlobalStats(
            total_users=int(data["total_users"]),
            total_tasks_completed=int(data["total_tasks_completed"]),
            active_users=active,
        )
    result = await session.execute(
        select(GlobalStats).order_by(GlobalStats.id).limit(1)
    )
    gs = result.scalar_one_or_none()
    active = await count_online(redis)
    if gs:
        return GlobalStats(
            total_users=gs.total_users,
            total_tasks_completed=gs.total_tasks_completed,
            active_users=active,
        )
    return GlobalStats(total_users=0, total_tasks_completed=0, active_users=active)


@router.post("/admin/recalculate")
async def recalc_stats(
    request: Request,
    current_admin=Depends(get_current_admin),
    session: AsyncSession = Depends(lambda: request.app.state.db_session),
    redis=Depends(lambda: request.app.state.redis_client),
):
    """Ручной пересчёт лидерборда и глобальной статистики."""
    total = await recalculate_stats(session, redis)
    return {"status": "ok", "message": f"Recalculated stats for {total} users"}
