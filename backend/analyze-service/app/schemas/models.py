from pydantic import BaseModel
from typing import List, Optional


class UserProgress(BaseModel):
    """
    Модель для представления прогресса пользователя.

    Attributes:
        user_id (int): идентификатор пользователя.
        tasks_completed (int): количество выполненных заданий.
    """
    user_id: int
    tasks_completed: int


class GlobalStats(BaseModel):
    """
    Модель для представления глобальной статистики приложения.

    Attributes:
        total_users (int): общее число пользователей.
        total_tasks_completed (int): общее количество выполненных заданий.
        active_users (int): число активных пользователей (из Redis).
    """
    total_users: int
    total_tasks_completed: int
    active_users: int


class LeaderboardEntry(BaseModel):
    """
    Модель для представления записи в лидерборде.

    Attributes:
        user_id (int): идентификатор пользователя.
        tasks_completed (int): количество выполненных заданий.
    """
    user_id: int
    tasks_completed: int


class LeaderboardResponse(BaseModel):
    """
    Модель для представления ответа эндпоинта лидерборда.

    Attributes:
        top (List[LeaderboardEntry]): список топ-10 записей.
        user_rank (Optional[int]): позиция текущего пользователя, если он не входит в топ-10.
    """
    top: List[LeaderboardEntry]
    user_rank: Optional[int] = None
