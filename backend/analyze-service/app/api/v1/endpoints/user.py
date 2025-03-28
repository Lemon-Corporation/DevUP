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
    Получает прогресс конкретного пользователя.

    Args:
        user_id (int): идентификатор пользователя, чей прогресс требуется.
        request (Request): объект запроса, для доступа к состоянию приложения.
        current_user: данные текущего аутентифицированного пользователя.

    Returns:
        UserProgress: модель с данными прогресса пользователя.
    """
    db_pool = request.app.state.db_pool
    async with db_pool.acquire() as conn:
        row = await conn.fetchrow(
            "SELECT user_id, tasks_completed FROM user_progress WHERE user_id = $1;", user_id
        )
        if not row:
            return UserProgress(user_id=user_id, tasks_completed=0)
        return UserProgress(**dict(row))
