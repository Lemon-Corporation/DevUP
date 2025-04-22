from fastapi import APIRouter, Request, Depends
from typing import List
from app.schemas.models import LeaderboardEntry, LeaderboardResponse
from app.core.auth import get_current_user, get_current_admin

router = APIRouter()


@router.get("/leaderboard", response_model=LeaderboardResponse)
async def get_leaderboard(
    request: Request,
    current_user=Depends(get_current_user)
):
    """
    Публичный лидерборд:
    - Топ-10 пользователей из Redis ZSET 'leaderboard'.
    - Позиция текущего пользователя (zrevrank+1).

    Args:
        request (Request): объект запроса.
        current_user: данные текущего пользователя.

    Returns:
        LeaderboardResponse: топ и ранг.
    """
    redis = request.app.state.redis_client
    raw_top = await redis.zrevrange("leaderboard", 0, 9, withscores=True)
    top = [
        LeaderboardEntry(user_id=int(uid), tasks_completed=int(score))
        for uid, score in raw_top
    ]

    rank = await redis.zrevrank("leaderboard", current_user.sub)
    user_rank = rank + 1 if rank is not None else None

    return LeaderboardResponse(top=top, user_rank=user_rank)


@router.get("/admin/leaderboard", response_model=List[LeaderboardEntry])
async def get_full_leaderboard(
    request: Request,
    current_admin=Depends(get_current_admin)
):
    """
    Полный лидерборд для админов из Redis ZSET 'leaderboard'.

    Args:
        request (Request): объект запроса.
        current_admin: данные администратора.

    Returns:
        List[LeaderboardEntry]: все записи отсортированы по убыванию.
    """
    redis = request.app.state.redis_client
    raw = await redis.zrevrange("leaderboard", 0, -1, withscores=True)
    return [
        LeaderboardEntry(user_id=int(uid), tasks_completed=int(score))
        for uid, score in raw
    ]
