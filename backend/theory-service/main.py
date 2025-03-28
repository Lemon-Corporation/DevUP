import logging
from fastapi import FastAPI
import uvicorn

from app.core.config import settings
from app.core.init_app import startup_event, shutdown_event
from app.api.v1.endpoints import theory

logger = logging.getLogger("theory_service")
logging.basicConfig(level=logging.INFO)

def create_app() -> FastAPI:
    """
    Создает и настраивает экземпляр FastAPI приложения.
    """
    app = FastAPI(
        title="TheoryService",
        description="API-сервис для хранения и управления теоретическими материалами по программированию",
    )

    @app.on_event("startup")
    async def on_startup():
        await startup_event(app)

    @app.on_event("shutdown")
    async def on_shutdown():
        await shutdown_event(app)

    # Пинг для проверки работоспособности
    @app.get("/ping")
    async def ping():
        return {"message": "pong"}

    # Подключаем роутеры
    app.include_router(theory.router, prefix="/api/v1", tags=["Theory"])

    return app

app = create_app()

if __name__ == "__main__":
    uvicorn.run("main:app", host=settings.SERVICE_HOST,
                port=settings.SERVICE_PORT, reload=True)
