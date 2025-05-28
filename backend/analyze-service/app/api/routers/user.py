from fastapi import APIRouter, Depends, HTTPException, Request, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.auth import get_current_user
from app.schemas.user import UserProgressResponse
from app.services.progress_service import get_user_progress_data

router = APIRouter()


@router.get("/user/progress/{user_id}", response_model=UserProgressResponse)
async def get_user_progress(
    user_id: int,
    request: Request,
    current_user=Depends(get_current_user),
    session: AsyncSession = Depends(lambda: request.app.state.db_session),
    redis=Depends(lambda: request.app.state.redis_client),
):
    """Возвращает прогресс указанного пользователя."""
    try:
        token_user_id = int(current_user.sub)
    except Exception:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED)
    if current_user.role != "admin" and token_user_id != user_id:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN)
    tasks = await get_user_progress_data(session, redis, user_id)
    return UserProgressResponse(user_id=user_id, tasks_completed=tasks)
