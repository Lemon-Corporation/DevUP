from fastapi import APIRouter, Request, Depends
from app.schemas.models import GlobalStats
from app.core.auth import get_current_admin

router = APIRouter()


async def _count_online(redis) -> int:
    """
    Подсчитывает ключи online:* через SCAN, чтобы не блокировать Redis.

    Args:
        redis: клиент Redis.

    Returns:
        int: количество активных пользователей.
    """
    cnt = 0
    cur = b'0'
    while cur:
        cur, keys = await redis.scan(cursor=cur, match="online:*", count=100)
        cnt += len(keys)
    return cnt


@router.post("/admin/recalculate")
async def admin_recalculate_stats(
    request: Request,
    current_admin=Depends(get_current_admin)
):
    """
    Ручной пересчет статистики:
    - Читает все user_progress из БД.

    Args:
        request (Request): объект запроса.
        current_admin: данные администратора.

    Returns:
        dict: сообщение о количестве записей.
    """
    db = request.app.state.db_pool
    async with db.acquire() as conn:
        rows = await conn.fetch("SELECT user_id, tasks_completed FROM user_progress;")
    return {"status": "ok", "message": f"Recalculated stats for {len(rows)} users"}


@router.get("/admin/app_activity", response_model=GlobalStats)
async def get_app_activity(
    request: Request,
    current_admin=Depends(get_current_admin)
):
    """
    Возвращает расширенную активность приложения:
    - Из Redis hash 'stats:global' (TTL=60s) или из БД.
    - Количество активных пользователей через SCAN('online:*').

    Args:
        request (Request): объект запроса.
        current_admin: данные администратора.

    Returns:
        GlobalStats: общее число пользователей, выполненных заданий и активных онлайн.
    """
    redis = request.app.state.redis_client
    raw = await redis.hgetall("stats:global")
    if raw:
        return GlobalStats(
            total_users=int(raw["total_users"]),
            total_tasks_completed=int(raw["total_tasks_completed"]),
            active_users=await _count_online(redis)
        )

    db = request.app.state.db_pool
    async with db.acquire() as conn:
        row = await conn.fetchrow(
            "SELECT total_users, total_tasks_completed FROM global_stats ORDER BY id LIMIT 1;"
        )
    total_users = row["total_users"]
    total_tasks = row["total_tasks_completed"]
    active = await _count_online(redis)

    await redis.hset("stats:global", mapping={
        "total_users": str(total_users),
        "total_tasks_completed": str(total_tasks)
    })
    await redis.expire("stats:global", 60)

    return GlobalStats(
        total_users=total_users,
        total_tasks_completed=total_tasks,
        active_users=active
    )
