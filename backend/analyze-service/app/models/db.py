from typing import Optional

from sqlalchemy.ext.asyncio import AsyncSession, AsyncAttrs, create_async_engine
from sqlalchemy.orm import declarative_base, sessionmaker, Mapped, mapped_column

Base = declarative_base()


class UserProgress(AsyncAttrs, Base):
    """Количество выполненных заданий пользователем."""
    __tablename__ = "user_progress"
    user_id: Mapped[int] = mapped_column(primary_key=True)
    tasks_completed: Mapped[int] = mapped_column(default=0)


class GlobalStats(AsyncAttrs, Base):
    """Глобальная статистика приложения."""
    __tablename__ = "global_stats"
    id: Mapped[int] = mapped_column(primary_key=True, autoincrement=True)
    total_users: Mapped[int] = mapped_column(default=0)
    total_tasks_completed: Mapped[int] = mapped_column(default=0)


engine = None
AsyncSessionLocal = None


def init_engine(dsn: str) -> None:
    """Создаёт AsyncEngine и фабрику сессий."""
    global engine, AsyncSessionLocal
    engine = create_async_engine(dsn, echo=False)
    AsyncSessionLocal = sessionmaker(
        bind=engine,
        class_=AsyncSession,
        expire_on_commit=False,
    )
