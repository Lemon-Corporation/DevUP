from fastapi import FastAPI
from app.api.routers.notifications import router as notif_router
from app.api.routers.subscriptions import router as sub_router
from app.models.db import async_engine, Base
from sqlalchemy.ext.asyncio import AsyncEngine

app = FastAPI(
    title="NotificationService",
    description="Сервис уведомлений DevUP",
    version="2.0.0")

app.include_router(
    notif_router, prefix="/api/v1/notifications", tags=["notifications"])
app.include_router(sub_router, prefix="/api/v1/subscriptions",
                   tags=["subscriptions"])


@app.on_event("startup")
async def create_schema() -> None:
    """Создаёт таблицы асинхронно при первом запуске."""
    async with async_engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)
