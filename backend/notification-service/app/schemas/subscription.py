from datetime import datetime
from pydantic import BaseModel


class SubscriptionBase(BaseModel):
    """Пара «пользователь–тип» для (от)подписки."""
    user_id: int
    type: str


class SubscriptionSchema(SubscriptionBase):
    """Презентация подписки на БД."""
    id: int
    created_at: datetime

    class Config:
        orm_mode = True
