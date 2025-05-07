import logging
from fastapi import FastAPI
import uvicorn

from app.core.config import settings
from app.core.init_app import startup_event, shutdown_event
from app.api.v1.endpoints import user, leaderboard, admin

logger = logging.getLogger("analyze_service")
logging.basicConfig(level=logging.INFO)


def create_app() -> FastAPI:
    """
    Создает и настраивает экземпляр FastAPI:
    - Регистрирует обработчики событий старта/остановки.
    - Подключает роутеры для User, Leaderboard и Admin.
    """
    app = FastAPI(
        title="AnalyzeService",
        description="Сервис аналитики: прогресс, лидерборд, активность",
    )

    @app.on_event("startup")
    async def on_startup():
        """
        Обработчик события 'startup':
        Инициализирует подключения к PostgreSQL и Redis.
        """
        await startup_event(app)

    @app.on_event("shutdown")
    async def on_shutdown():
        """
        Обработчик события 'shutdown':
        Закрывает подключения к PostgreSQL и Redis.
        """
        await shutdown_event(app)

    app.include_router(user.router, prefix="/api/v1", tags=["User"])
    app.include_router(leaderboard.router, prefix="/api/v1",
                       tags=["Leaderboard"])
    app.include_router(admin.router, prefix="/api/v1", tags=["Admin"])
    return app


app = create_app()

if __name__ == "__main__":
    uvicorn.run(
        "app.main:app",
        host=settings.SERVICE_HOST,
        port=settings.SERVICE_PORT,
        reload=True
    )
