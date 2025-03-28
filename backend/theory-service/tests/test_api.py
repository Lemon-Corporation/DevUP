"""
Тесты для микросервиса TheoryService.
"""

from fastapi.testclient import TestClient
from app.main import app
from app.core.auth import TokenData, get_current_user, get_current_admin

# Фиктивные данные для тестирования
dummy_user = TokenData(sub="123", role="user")
dummy_admin = TokenData(sub="999", role="admin")

# Переопределяем зависимости
app.dependency_overrides[get_current_user] = lambda: dummy_user
app.dependency_overrides[get_current_admin] = lambda: dummy_admin

client = TestClient(app)

def test_ping():
    response = client.get("/ping")
    assert response.status_code == 200
    assert response.json() == {"message": "pong"}

# Ниже можно добавить дополнительные тесты, аналогичные тому,
# что было в analyze-service, но ориентированные на таблицу theory_materials.
