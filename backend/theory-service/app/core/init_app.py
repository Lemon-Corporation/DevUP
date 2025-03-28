import logging
import asyncpg
import redis.asyncio as aioredis

from app.core.config import settings
from app.db.init_db import init_db, init_db_pool

logger = logging.getLogger("theory_service")

async def startup_event(app):
    """
    Инициализация приложения при старте:
    - Создание пула подключений к PostgreSQL.
    - Инициализация схемы БД.
    - Установка соединения с Redis.
    """
    app.state.db_pool = await init_db_pool(settings.POSTGRES_DSN)
    await init_db(app.state.db_pool)

    app.state.redis_client = aioredis.from_url(
        settings.REDIS_DSN,
        encoding="utf-8",
        decode_responses=True
    )
    logger.info("TheoryService started.")

async def shutdown_event(app):
    """
    Закрытие приложения:
    - Закрытие пула подключений к PostgreSQL.
    - Закрытие соединения с Redis.
    """
    if app.state.db_pool:
        await app.state.db_pool.close()
    if app.state.redis_client:
        await app.state.redis_client.close()
    logger.info("TheoryService shutdown.")
