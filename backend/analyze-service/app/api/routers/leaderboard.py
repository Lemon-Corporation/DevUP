from fastapi import APIRouter, Depends, HTTPException, Request, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.auth import get_current_user, get_current_admin
from app.schemas.leaderboard import LeaderboardResponse, LeaderboardEntry
from app.services.leaderboard_service import get_top_leaderboard, get_user_rank
from app.models.db import UserProgress

router = APIRouter()


@router.get("/leaderboard", response_model=LeaderboardResponse)
async def leaderboard(
    request: Request,
    current_user=Depends(get_current_user),
    session: AsyncSession = Depends(lambda: request.app.state.db_session),
    redis=Depends(lambda: request.app.state.redis_client),
):
    """Публичный топ-10 и ранг текущего пользователя."""
    top_list = await get_top_leaderboard(session, redis, top_n=10)
    try:
        rank_idx = await redis.zrevrank("leaderboard", current_user.sub)
        user_rank = rank_idx + 1 if rank_idx is not None else None
    except Exception:
        user_rank = await get_user_rank(session, int(current_user.sub))
    return LeaderboardResponse(
        top=[LeaderboardEntry(**e) for e in top_list],
        user_rank=user_rank,
    )


@router.get("/admin/leaderboard", response_model=list[LeaderboardEntry])
async def full_leaderboard(
    request: Request,
    current_admin=Depends(get_current_admin),
    session: AsyncSession = Depends(lambda: request.app.state.db_session),
    redis=Depends(lambda: request.app.state.redis_client),
):
    """Полный лидерборд, доступен только админу."""
    try:
        raw = await redis.zrevrange("leaderboard", 0, -1, withscores=True)
        if raw is not None:
            return [
                LeaderboardEntry(user_id=int(uid), tasks_completed=int(score))
                for uid, score in raw
            ]
    except Exception:
        pass
    result = await session.execute(
        select(UserProgress).order_by(UserProgress.tasks_completed.desc())
    )
    all_users = result.scalars().all()
    return [
        LeaderboardEntry(user_id=u.user_id, tasks_completed=u.tasks_completed)
        for u in all_users
    ]
