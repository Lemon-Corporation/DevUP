from sqlalchemy.ext.asyncio import AsyncSession, async_sessionmaker, create_async_engine
from sqlalchemy.orm import DeclarativeBase
from app.core.config import settings

async_engine = create_async_engine(settings.POSTGRES_DSN, echo=False)
AsyncSessionLocal = async_sessionmaker(async_engine, expire_on_commit=False)


class Base(DeclarativeBase):
    """Декларативная база для моделей ORM."""


async def get_db():
    """Создает AsyncSession и гарантирует его закрытие."""
    async with AsyncSessionLocal() as session:
        yield session
