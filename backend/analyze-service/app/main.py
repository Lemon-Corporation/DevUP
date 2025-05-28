import logging

from fastapi import FastAPI
from redis.asyncio import from_url as redis_from_url
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.config import settings
from app.models import db as db_models
from app.api.routers import user, leaderboard, admin

logger = logging.getLogger("analyze_service")
logging.basicConfig(level=logging.INFO)


def create_app() -> FastAPI:
    app = FastAPI(
        title="AnalyzeService",
        description="Сервис аналитики DevUP",
        version="2.0.0",
    )

    @app.on_event("startup")
    async def on_startup() -> None:
        db_models.init_engine(settings.POSTGRES_DSN)
        app.state.db_session = db_models.AsyncSessionLocal()
        try:
            async with db_models.engine.begin() as conn:
                await conn.execute("SELECT 1")
            logger.info("Connected to PostgreSQL")
        except Exception as exc:
            logger.error(f"PostgreSQL unavailable: {exc}")
        try:
            app.state.redis_client = redis_from_url(
                settings.REDIS_DSN,
                encoding="utf-8",
                decode_responses=True,
            )
            await app.state.redis_client.ping()
            logger.info("Connected to Redis")
        except Exception as exc:
            logger.error(f"Redis unavailable: {exc}")

    @app.on_event("shutdown")
    async def on_shutdown() -> None:
        session: AsyncSession = app.state.db_session
        await session.close()
        if db_models.engine:
            await db_models.engine.dispose()
        try:
            await app.state.redis_client.close()
        except Exception:
            pass
        logger.info("Shutdown complete")

    app.include_router(user.router, prefix="/api/v1", tags=["User"])
    app.include_router(leaderboard.router, prefix="/api/v1", tags=["Leaderboard"])
    app.include_router(admin.router, prefix="/api/v1", tags=["Admin"])
    return app


app = create_app()
