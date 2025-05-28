import logging
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, func
from app.models.db import UserProgress

logger = logging.getLogger("analyze_service")


async def get_top_leaderboard(session: AsyncSession, redis, top_n: int = 10):
    """Возвращает топ-N пользователей."""
    try:
        raw_top = await redis.zrevrange("leaderboard", 0, top_n - 1, withscores=True)
        if raw_top is not None:
            return [
                {"user_id": int(uid), "tasks_completed": int(score)}
                for uid, score in raw_top
            ]
    except Exception:
        pass
    result = await session.execute(
        select(UserProgress).order_by(UserProgress.tasks_completed.desc()).limit(top_n)
    )
    top_users = result.scalars().all()
    return [
        {"user_id": u.user_id, "tasks_completed": u.tasks_completed}
        for u in top_users
    ]


async def get_user_rank(session: AsyncSession, user_id: int):
    """Определяет ранг пользователя по числу выполненных заданий."""
    result = await session.execute(
        select(UserProgress.tasks_completed).where(UserProgress.user_id == user_id)
    )
    user_tasks = result.scalar_one_or_none()
    if user_tasks is None:
        return None
    count_result = await session.execute(
        select(func.count()).select_from(UserProgress).where(
            UserProgress.tasks_completed > user_tasks
        )
    )
    higher_count = count_result.scalar_one() or 0
    return higher_count + 1
