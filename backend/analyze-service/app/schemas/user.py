from pydantic import BaseModel


class UserProgressResponse(BaseModel):
    """Прогресс конкретного пользователя."""
    user_id: int
    tasks_completed: int
