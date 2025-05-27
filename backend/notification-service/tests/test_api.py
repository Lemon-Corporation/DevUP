import pytest
import httpx
from fastapi import FastAPI
from sqlalchemy.ext.asyncio import AsyncSession, create_async_engine, async_sessionmaker
from app.main import app as fastapi_app
from app.models.db import Base, get_db
from app.core.config import settings
from app.services.notification_service import redis_client

DATABASE_URL = "sqlite+aiosqlite:///:memory:"
engine = create_async_engine(DATABASE_URL, future=True)
AsyncTestingSessionLocal = async_sessionmaker(engine, expire_on_commit=False)


async def override_get_db():
    async with AsyncTestingSessionLocal() as session:
        yield session


fastapi_app.dependency_overrides[get_db] = override_get_db


class DummyRedis(dict):
    async def get(self, key):
        return super().get(key)

    async def set(self, key, val, ex=None):
        super().__setitem__(key, val)

    async def delete(self, key):
        super().pop(key, None)


redis_client.__class__ = DummyRedis

@pytest.fixture(autouse=True, scope="session")
async def prepare_db():
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)
    yield


@pytest.fixture
async def client():
    async with httpx.AsyncClient(app=fastapi_app, base_url="http://test") as c:
        yield c


headers = {"X-Admin-Token": settings.ADMIN_TOKEN}


@pytest.mark.asyncio
async def test_subscribe_unsubscribe(client: httpx.AsyncClient):
    body = {"user_id": 1, "type": "news"}
    assert (await client.post("/api/v1/subscriptions", json=body, headers=headers)).status_code == 200
    assert (await client.post("/api/v1/subscriptions", json=body, headers=headers)).status_code == 400
    assert (await client.delete("/api/v1/subscriptions", json=body, headers=headers)).status_code == 200
    assert (await client.delete("/api/v1/subscriptions", json=body, headers=headers)).status_code == 400


@pytest.mark.asyncio
async def test_send_and_get(client: httpx.AsyncClient):
    sub = {"user_id": 2, "type": "task"}
    await client.post("/api/v1/subscriptions", json=sub, headers=headers)
    payload = {"user_id": 2, "type": "task", "message": "hello"}
    assert (await client.post("/api/v1/notifications/send", json=payload, headers=headers)).status_code == 200
    resp = await client.get("/api/v1/notifications/user/2")
    assert resp.status_code == 200 and resp.json()[0]["message"] == "hello"


@pytest.mark.asyncio
async def test_send_rejected(client: httpx.AsyncClient):
    payload = {"user_id": 3, "type": "other", "message": "noop"}
    assert (await client.post("/api/v1/notifications/send", json=payload, headers=headers)).status_code == 400
