from pydantic import BaseModel
from typing import List, Optional


class LeaderboardEntry(BaseModel):
    """Запись лидерборда."""
    user_id: int
    tasks_completed: int


class LeaderboardResponse(BaseModel):
    """Ответ с топ-N и ранком пользователя."""
    top: List[LeaderboardEntry]
    user_rank: Optional[int]
