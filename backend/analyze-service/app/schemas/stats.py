from pydantic import BaseModel


class GlobalStats(BaseModel):
    """Сводная статистика приложения."""
    total_users: int
    total_tasks_completed: int
    active_users: int
