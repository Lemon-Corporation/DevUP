import json
import redis.asyncio as redis
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession
from app.core.config import settings
from app.models.notification import Notification
from app.models.subscription import Subscription
from app.schemas.notification import NotificationSchema

redis_client = redis.from_url(settings.REDIS_DSN, decode_responses=True)


async def get_notifications(db: AsyncSession, user_id: int):
    """Возвращает уведомления пользователю, использует кэш Redis."""
    key = f"notifications:{user_id}"
    if cached := await redis_client.get(key):
        return [NotificationSchema(**item) for item in json.loads(cached)]
    res = await db.execute(
        select(Notification).where(Notification.user_id == user_id).order_by(Notification.created_at.desc())
    )
    rows = res.scalars().all()
    data = [NotificationSchema.from_orm(r) for r in rows]
    await redis_client.set(key, json.dumps([d.dict() for d in data]), ex=settings.CACHE_EXPIRE)
    return data


async def send_notification(db: AsyncSession, user_id: int, notif_type: str, message: str):
    """Создает уведомление, если подписка существует; возвращает схему или None."""
    res = await db.execute(
        select(Subscription).where(Subscription.user_id == user_id, Subscription.type == notif_type)
    )
    if res.scalar_one_or_none() is None:
        return None
    record = Notification(user_id=user_id, type=notif_type, message=message)
    db.add(record)
    await db.commit()
    await db.refresh(record)
    await redis_client.delete(f"notifications:{user_id}")
    return NotificationSchema.from_orm(record)
