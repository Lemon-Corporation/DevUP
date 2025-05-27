from datetime import datetime
from pydantic import BaseModel


class NotificationBase(BaseModel):
    """Общие поля уведомлений."""
    user_id: int
    type: str
    message: str


class NotificationCreate(NotificationBase):
    """Текст запроса на отправку уведомления."""
    pass


class NotificationSchema(NotificationBase):
    """Ответный орган для уведомления."""
    id: int
    created_at: datetime

    class Config:
        orm_mode = True
