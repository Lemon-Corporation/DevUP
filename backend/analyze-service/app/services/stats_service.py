import logging
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from app.models.db import UserProgress, GlobalStats

logger = logging.getLogger("analyze_service")


async def count_online(redis) -> int:
    """Считает активных пользователей по ключам online:*."""
    try:
        cursor = b"0"
        count = 0
        while cursor:
            cursor, keys = await redis.scan(cursor=cursor, match="online:*", count=100)
            count += len(keys)
        return count
    except Exception:
        return 0


async def recalculate_stats(session: AsyncSession, redis):
    """Полный пересчёт лидерборда и глобальной статистики."""
    result = await session.execute(select(UserProgress))
    all_users = result.scalars().all()
    total_users = len(all_users)
    total_tasks = sum(u.tasks_completed for u in all_users)
    try:
        await redis.delete("leaderboard")
        if total_users:
            await redis.zadd(
                "leaderboard",
                mapping={str(u.user_id): u.tasks_completed for u in all_users},
            )
    except Exception:
        pass
    gs = await session.get(GlobalStats, 1)
    if gs:
        gs.total_users = total_users
        gs.total_tasks_completed = total_tasks
    else:
        gs = GlobalStats(
            total_users=total_users,
            total_tasks_completed=total_tasks,
        )
        session.add(gs)
    await session.commit()
    try:
        await redis.hset(
            "stats:global",
            mapping={
                "total_users": str(total_users),
                "total_tasks_completed": str(total_tasks),
            },
        )
        await redis.expire("stats:global", 60)
    except Exception:
        pass
    return total_users
