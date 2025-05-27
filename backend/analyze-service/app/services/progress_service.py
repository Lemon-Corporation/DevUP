import logging
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from app.models.db import UserProgress

logger = logging.getLogger("analyze_service")


async def get_user_progress_data(session: AsyncSession, redis, user_id: int) -> int:
    """Возвращает количество выполненных заданий пользователем."""
    cache_key = f"user:progress:{user_id}"
    try:
        cached = await redis.get(cache_key)
    except Exception:
        cached = None
    if cached is not None:
        try:
            return int(cached)
        except ValueError:
            pass
    result = await session.execute(
        select(UserProgress).where(UserProgress.user_id == user_id)
    )
    user_progress = result.scalar_one_or_none()
    tasks = user_progress.tasks_completed if user_progress else 0
    try:
        await redis.set(cache_key, str(tasks), ex=60)
    except Exception:
        pass
    return tasks
