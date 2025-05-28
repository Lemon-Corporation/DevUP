from sqlalchemy import DateTime, Integer, String, UniqueConstraint, func
from sqlalchemy.orm import Mapped, mapped_column
from app.models.db import Base


class Subscription(Base):
    """Строка подписки ORM."""
    __tablename__ = "subscriptions"
    __table_args__ = (UniqueConstraint("user_id", "type", name="_user_type_uc"),)

    id: Mapped[int] = mapped_column(Integer, primary_key=True, index=True)
    user_id: Mapped[int] = mapped_column(Integer)
    type: Mapped[str] = mapped_column(String(50))
    created_at: Mapped[str] = mapped_column(DateTime(timezone=True), server_default=func.now())
