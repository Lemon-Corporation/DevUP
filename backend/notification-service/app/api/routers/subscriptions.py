from fastapi import APIRouter, Depends, Header, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from app.core.config import settings
from app.models.db import get_db
from app.schemas.subscription import SubscriptionBase
from app.services.subscription_service import subscribe, unsubscribe

router = APIRouter()


def admin_required(token: str = Header(None, alias="X-Admin-Token")):
    """Проверяет заголовок токена администратора."""
    if token != settings.ADMIN_TOKEN:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Unauthorized")


@router.post("/", dependencies=[Depends(admin_required)])
async def subscribe_user(payload: SubscriptionBase, db: AsyncSession = Depends(get_db)):
    """Подписывает пользователя на тип уведомлений."""
    if not await subscribe(db, payload.user_id, payload.type):
        raise HTTPException(status_code=400, detail="Subscription already exists")
    return {"message": "Subscribed successfully"}


@router.delete("/", dependencies=[Depends(admin_required)])
async def unsubscribe_user(payload: SubscriptionBase, db: AsyncSession = Depends(get_db)):
    """Отписывает пользователя от типа уведомлений."""
    if not await unsubscribe(db, payload.user_id, payload.type):
        raise HTTPException(status_code=400, detail="Subscription not found")
    return {"message": "Unsubscribed successfully"}
