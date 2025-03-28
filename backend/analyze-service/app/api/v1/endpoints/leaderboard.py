from fastapi import APIRouter, Request, Depends, HTTPException
from typing import List
from app.schemas.models import LeaderboardEntry, LeaderboardResponse
from app.core.auth import get_current_user, get_current_admin

router = APIRouter()


@router.get("/leaderboard", response_model=LeaderboardResponse)
async def get_leaderboard(request: Request, current_user=Depends(get_current_user)):
    """
    Возвращает публичный лидерборд:
    - Топ-10 пользователей по количеству выполненных заданий.
    - Позиция текущего пользователя, если он не входит в топ-10.

    Args:
        request (Request): объект запроса для доступа к состоянию приложения.
        current_user: данные текущего аутентифицированного пользователя.

    Returns:
        LeaderboardResponse: модель, содержащая топ-10 и позицию текущего пользователя.
    """
    db_pool = request.app.state.db_pool
    async with db_pool.acquire() as conn:
        # Получаем топ-10 пользователей
        top_rows = await conn.fetch("""
            SELECT user_id, tasks_completed
            FROM user_progress
            ORDER BY tasks_completed DESC
            LIMIT 10;
        """)
        top_list = [LeaderboardEntry(
            user_id=row["user_id"], tasks_completed=row["tasks_completed"]) for row in top_rows]

        # Получаем данные текущего пользователя
        user_row = await conn.fetchrow("""
            SELECT tasks_completed FROM user_progress WHERE user_id = $1;
        """, int(current_user.sub))
        if not user_row:
            user_rank = None
        else:
            # Вычисляем позицию пользователя: считаем количество пользователей с большим количеством выполненных заданий
            rank_row = await conn.fetchrow("""
                SELECT COUNT(*) + 1 as rank
                FROM user_progress
                WHERE tasks_completed > $1;
            """, user_row["tasks_completed"])
            user_rank = rank_row["rank"]

    return LeaderboardResponse(top=top_list, user_rank=user_rank)


@router.get("/admin/leaderboard", response_model=List[LeaderboardEntry])
async def get_full_leaderboard(request: Request, current_admin=Depends(get_current_admin)):
    """
    Админский эндпоинт, возвращающий полный список пользователей с их результатами для лидерборда.

    Args:
        request (Request): объект запроса для доступа к состоянию приложения.
        current_admin: данные текущего администратора (с проверкой JWT).

    Returns:
        List[LeaderboardEntry]: список всех пользователей, отсортированных по количеству выполненных заданий.
    """
    db_pool = request.app.state.db_pool
    async with db_pool.acquire() as conn:
        rows = await conn.fetch("""
            SELECT user_id, tasks_completed
            FROM user_progress
            ORDER BY tasks_completed DESC;
        """)
        full_list = [LeaderboardEntry(
            user_id=row["user_id"], tasks_completed=row["tasks_completed"]) for row in rows]
    return full_list
