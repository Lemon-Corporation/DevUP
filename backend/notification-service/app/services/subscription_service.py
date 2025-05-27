from sqlalchemy import delete, insert, select
from sqlalchemy.ext.asyncio import AsyncSession
from app.models.subscription import Subscription


async def subscribe(db: AsyncSession, user_id: int, notif_type: str) -> bool:
    """Добавляет подписку; возвращает False, если уже существует."""
    exists = await db.scalar(
        select(Subscription.id).where(Subscription.user_id == user_id, Subscription.type == notif_type)
    )
    if exists:
        return False
    await db.execute(insert(Subscription).values(user_id=user_id, type=notif_type))
    await db.commit()
    return True


async def unsubscribe(db: AsyncSession, user_id: int, notif_type: str) -> bool:
    """Удаляет подписку; возвращает False, если отсутствует."""
    result = await db.execute(
        delete(Subscription)
        .where(Subscription.user_id == user_id, Subscription.type == notif_type)
        .returning(Subscription.id)
    )
    if result.scalar_one_or_none() is None:
        return False
    await db.commit()
    return True
