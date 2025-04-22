from fastapi import APIRouter, Request, Depends
from app.schemas.models import UserProgress
from app.core.auth import get_current_user

router = APIRouter()


@router.get("/user/progress/{user_id}", response_model=UserProgress)
async def get_user_progress(
    user_id: int,
    request: Request,
    current_user=Depends(get_current_user)
):
    """
    Возвращает прогресс пользователя:
    - Пытается из Redis (key=user:progress:{user_id}, TTL=60s).
    - При неудачной попытке - из PostgreSQL, затем кеширует.

    Args:
        user_id (int): ID пользователя.
        request (Request): объект запроса для доступа к app.state.
        current_user: данные аутентифицированного пользователя.

    Returns:
        UserProgress: кол-во выполненных заданий.
    """
    redis = request.app.state.redis_client
    cache_key = f"user:progress:{user_id}"
    cached = await redis.get(cache_key)
    if cached is not None:
        return UserProgress(user_id=user_id, tasks_completed=int(cached))

    db = request.app.state.db_pool
    async with db.acquire() as conn:
        row = await conn.fetchrow(
            "SELECT tasks_completed FROM user_progress WHERE user_id = $1;", user_id
        )
    tasks = row["tasks_completed"] if row else 0
    await redis.set(cache_key, str(tasks), ex=60)
    return UserProgress(user_id=user_id, tasks_completed=tasks)
