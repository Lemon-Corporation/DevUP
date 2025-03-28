"""
Тесты для микросервиса AnalyzeService.

Покрываются следующие эндпоинты:
- GET /api/v1/user/progress/{user_id} – получение прогресса пользователя.
- GET /api/v1/leaderboard – публичный лидерборд (топ-10 + позиция текущего пользователя).
- GET /api/v1/admin/leaderboard – админский лидерборд (полный список).
- POST /api/v1/admin/recalculate – пересчет статистики.
- GET /api/v1/admin/app_activity – подробная активность приложения.
"""

import asyncio
from typing import List

import pytest
from fastapi.testclient import TestClient

from app.main import app
from app.schemas.models import TokenData
from app.core.auth import get_current_user, get_current_admin


class DummyConnection:
    async def fetchrow(self, query: str, *args):
        if "FROM user_progress WHERE user_id" in query:
            # Если запрашивается прогресс для пользователя с id=1
            user_id = args[0]
            if user_id == 1:
                return {"user_id": 1, "tasks_completed": 5}
            else:
                return None
        elif "SELECT COUNT(*) + 1 as rank" in query:
            # Для запроса позиции пользователя возвращаем, например, rank = 3
            return {"rank": 3}
        elif "SELECT COUNT(*) as cnt FROM global_stats" in query:
            return {"cnt": 1}
        elif "SELECT total_users, total_tasks_completed FROM global_stats" in query:
            return {"total_users": 100, "total_tasks_completed": 500}
        elif "SELECT tasks_completed FROM user_progress WHERE user_id" in query:
            return {"tasks_completed": 5}
        return None

    async def fetch(self, query: str, *args) -> List[dict]:
        if "FROM user_progress" in query and "LIMIT 10" in query:
            # Для топ-10 возвращаем 3 записи (пример)
            return [
                {"user_id": 1, "tasks_completed": 10},
                {"user_id": 2, "tasks_completed": 8},
                {"user_id": 3, "tasks_completed": 7},
            ]
        elif "FROM user_progress" in query:
            # Для полного списка возвращаем 4 записи
            return [
                {"user_id": 1, "tasks_completed": 10},
                {"user_id": 2, "tasks_completed": 8},
                {"user_id": 3, "tasks_completed": 7},
                {"user_id": 4, "tasks_completed": 5},
            ]
        return []

    async def __aenter__(self):
        return self

    async def __aexit__(self, exc_type, exc, tb):
        pass


class DummyDBPool:
    async def acquire(self):
        return DummyConnection()

    async def close(self):
        pass


class DummyRedis:
    async def keys(self, pattern: str) -> List[str]:
        # Возвращаем 3 ключа, что означает 3 активных пользователя
        return ["online:1", "online:2", "online:3"]

    async def close(self):
        pass


# Фиктивные данные токена для пользователя и администратора
dummy_user = TokenData(sub="1", role="user")
dummy_admin = TokenData(sub="1", role="admin")

# Переопределяем зависимости для тестирования
app.dependency_overrides[get_current_user] = lambda: dummy_user
app.dependency_overrides[get_current_admin] = lambda: dummy_admin

# Подставляем фиктивный пул БД и клиент Redis в состояние приложения
app.state.db_pool = DummyDBPool()
app.state.redis_client = DummyRedis()

# Создаем клиента для тестирования
client = TestClient(app)


def test_get_user_progress():
    """
    Тестирует эндпоинт GET /api/v1/user/progress/{user_id}.

    Проверяет, что для user_id=1 возвращается корректный результат с количеством выполненных заданий.
    """
    response = client.get("/api/v1/user/progress/1")
    assert response.status_code == 200, response.text
    data = response.json()
    assert data["user_id"] == 1
    assert data["tasks_completed"] == 5


def test_get_leaderboard():
    """
    Тестирует публичный эндпоинт GET /api/v1/leaderboard.

    Проверяет, что возвращаются топ-10 пользователей и позиция текущего пользователя.
    """
    response = client.get("/api/v1/leaderboard")
    assert response.status_code == 200, response.text
    data = response.json()
    # Проверяем наличие ключей 'top' и 'user_rank'
    assert "top" in data
    assert isinstance(data["top"], list)
    # Dummy возвращает 3 записи
    assert len(data["top"]) == 3
    assert "user_rank" in data
    # Dummy для позиции возвращает 3
    assert data["user_rank"] == 3


def test_get_full_leaderboard():
    """
    Тестирует админский эндпоинт GET /api/v1/admin/leaderboard.

    Проверяет, что возвращается полный список пользователей (в данном случае 4 записи).
    """
    response = client.get("/api/v1/admin/leaderboard")
    assert response.status_code == 200, response.text
    data = response.json()
    assert isinstance(data, list)
    assert len(data) == 4


def test_admin_recalculate_stats():
    """
    Тестирует эндпоинт POST /api/v1/admin/recalculate.

    Проверяет, что возвращается сообщение со статусом "ok" и упоминанием количества пользователей.
    """
    response = client.post("/api/v1/admin/recalculate")
    assert response.status_code == 200, response.text
    data = response.json()
    assert data.get("status") == "ok"
    assert "Recalculated stats for" in data.get("message", "")


def test_get_app_activity():
    """
    Тестирует эндпоинт GET /api/v1/admin/app_activity.

    Проверяет, что возвращаемая глобальная статистика содержит ключи 'total_users', 'total_tasks_completed'
    и 'active_users', а также соответствует нашим фиктивным данным.
    """
    response = client.get("/api/v1/admin/app_activity")
    assert response.status_code == 200, response.text
    data = response.json()
    assert "total_users" in data
    assert "total_tasks_completed" in data
    assert "active_users" in data
    # Dummy: total_users=100, total_tasks_completed=500, active_users=3
    assert data["total_users"] == 100
    assert data["total_tasks_completed"] == 500
    assert data["active_users"] == 3
