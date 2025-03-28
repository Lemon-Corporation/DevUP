from fastapi import APIRouter, Request, HTTPException, Depends
from app.schemas.models import GlobalStats
from app.core.auth import get_current_admin

router = APIRouter()


@router.post("/admin/recalculate")
async def admin_recalculate_stats(
    request: Request,
    current_admin=Depends(get_current_admin)
):
    """
    Пересчитывает статистику по всем пользователям.

    Args:
        request (Request): объект запроса для доступа к состоянию приложения.
        current_admin: данные текущего администратора (с проверкой JWT).

    Returns:
        dict: сообщение о выполнении пересчета статистики.
    """
    db_pool = request.app.state.db_pool
    async with db_pool.acquire() as conn:
        rows = await conn.fetch("SELECT user_id, tasks_completed FROM user_progress;")
    return {"status": "ok", "message": f"Recalculated stats for {len(rows)} users"}


@router.get("/admin/app_activity", response_model=GlobalStats)
async def get_app_activity(
    request: Request,
    current_admin=Depends(get_current_admin)
):
    """
    Возвращает подробную активность приложения, включая:
    - Общее число пользователей.
    - Общее количество выполненных заданий.
    - Число активных пользователей (определяется по ключам в Redis).

    Args:
        request (Request): объект запроса для доступа к состоянию приложения.
        current_admin: данные текущего администратора (с проверкой JWT).

    Returns:
        GlobalStats: модель глобальной статистики.
    """
    db_pool = request.app.state.db_pool
    redis_client = request.app.state.redis_client
    async with db_pool.acquire() as conn:
        row = await conn.fetchrow("SELECT total_users, total_tasks_completed FROM global_stats ORDER BY id LIMIT 1;")
        if not row:
            raise HTTPException(
                status_code=404, detail="Global stats not found")
    keys = await redis_client.keys("online:*")
    active_users = len(keys)
    return GlobalStats(
        total_users=row["total_users"],
        total_tasks_completed=row["total_tasks_completed"],
        active_users=active_users
    )
