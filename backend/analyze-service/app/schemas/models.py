from pydantic import BaseModel
from typing import List, Optional


class UserProgress(BaseModel):
    """
    Модель ответа: прогресс пользователя.
    """
    user_id: int
    tasks_completed: int


class LeaderboardEntry(BaseModel):
    """
    Запись лидерборда: пользователь и число выполненных заданий.
    """
    user_id: int
    tasks_completed: int


class LeaderboardResponse(BaseModel):
    """
    Модель ответа топ-10.
    """
    top: List[LeaderboardEntry]
    user_rank: Optional[int] = None


class GlobalStats(BaseModel):
    """
    Модель глобальной статистики приложения.
    """
    total_users: int
    total_tasks_completed: int
    active_users: int
