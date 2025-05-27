from fastapi import APIRouter, Depends, Header, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from app.core.config import settings
from app.models.db import get_db
from app.schemas.notification import NotificationCreate, NotificationSchema
from app.services.notification_service import get_notifications, send_notification

router = APIRouter()


def admin_required(token: str = Header(None, alias="X-Admin-Token")):
    """Проверяет заголовок токена администратора."""
    if token != settings.ADMIN_TOKEN:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Unauthorized")


@router.get("/user/{user_id}", response_model=list[NotificationSchema])
async def list_user_notifications(user_id: int, db: AsyncSession = Depends(get_db)):
    """Возвращает уведомления для указанного пользователя."""
    return await get_notifications(db, user_id)


@router.post("/send", response_model=NotificationSchema, dependencies=[Depends(admin_required)])
async def create_notification(payload: NotificationCreate, db: AsyncSession = Depends(get_db)):
    """Создает уведомление для подписанного пользователя."""
    result = await send_notification(db, payload.user_id, payload.type, payload.message)
    if result is None:
        raise HTTPException(status_code=400, detail="User not subscribed to this notification type")
    return result
