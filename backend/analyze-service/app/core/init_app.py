import logging
import asyncpg
import redis.asyncio as aioredis

from app.core.config import settings
from app.db.init_db import init_db, init_db_pool

logger = logging.getLogger("analyze_service")


async def startup_event(app):
    """
    Инициализирует приложение при старте:
    - Создает пул подключений к PostgreSQL и инициализирует схему БД.
    - Устанавливает соединение с Redis.

    Args:
        app (FastAPI): экземпляр FastAPI приложения.
    """
    app.state.db_pool = await init_db_pool(settings.POSTGRES_DSN)
    await init_db(app.state.db_pool)

    app.state.redis_client = aioredis.from_url(
        settings.REDIS_DSN,
        encoding="utf-8",
        decode_responses=True
    )
    logger.info("AnalyzeService started.")


async def shutdown_event(app):
    """
    Завершает работу приложения:
    - Закрывает пул подключений к PostgreSQL.
    - Закрывает соединение с Redis.

    Args:
        app (FastAPI): экземпляр FastAPI приложения.
    """
    if app.state.db_pool:
        await app.state.db_pool.close()
    if app.state.redis_client:
        await app.state.redis_client.close()
    logger.info("AnalyzeService shutdown.")
