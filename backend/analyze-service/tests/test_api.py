import pytest
from fastapi.testclient import TestClient

from app.main import app
from app.core.auth import get_current_user, get_current_admin, TokenData

dummy_user = TokenData(sub="1", role="user")
dummy_admin = TokenData(sub="1", role="admin")
app.dependency_overrides[get_current_user] = lambda: dummy_user
app.dependency_overrides[get_current_admin] = lambda: dummy_admin


class DummyDBSession:
    """Заглушка асинхронной сессии для тестов."""
    async def execute(self, query, *args, **kwargs):
        query_str = str(query)
        if "FROM user_progress WHERE user_progress.user_id" in query_str:
            uid = query._where_criteria[0].right.value
            class R:  
                def scalar_one_or_none(self):
                    return type("UP", (), {"tasks_completed": 5})() if uid == 1 else None
            return R()
        if "ORDER BY user_progress.tasks_completed DESC" in query_str:
            class R:
                def scalars(self):
                    class U:  
                        def __init__(self, uid, tasks):  
                            self.user_id = uid; self.tasks_completed = tasks
                    return [U(3, 10), U(2, 8), U(1, 5)]
            return R()
        if "COUNT" in query_str and ">" in query_str:
            class R:  
                def scalar_one(self):  
                    return 2
            return R()
        if "FROM global_stats" in query_str:
            class GS:  
                total_users = 100; total_tasks_completed = 500
            class R:  
                def scalar_one_or_none(self):  
                    return GS()
            return R()
        class R:
            def scalar_one_or_none(self):  
                return None
            def scalars(self):  
                return []
        return R()
    async def get(self, model, pk):  
        return None
    async def commit(self):  
        pass
    async def close(self):  
        pass


class DummyRedis:
    def __init__(self):  
        self.data = {}
    async def get(self, k):  
        return self.data.get(k)
    async def set(self, k, v, ex=None):  
        self.data[k] = v
    async def zrevrange(self, n, a, b, withscores=False):
        data = [("3", 10.0), ("2", 8.0), ("1", 5.0)]
        return data if withscores else [d[0] for d in data]
    async def zrevrank(self, n, m):
        try:
            return ["3", "2", "1"].index(m)
        except ValueError:
            return None
    async def hgetall(self, n):  
        return {}
    async def hset(self, n, mapping):  
        self.data.update(mapping)
    async def expire(self, n, t):  
        pass
    async def scan(self, cursor=0, match=None, count=None):
        return (None, ["online:1", "online:2", "online:3"]) if cursor in (0, b"0") else (None, [])
    async def delete(self, k):  
        self.data.pop(k, None)
    async def close(self):  
        pass


app.state.db_session = DummyDBSession()
app.state.redis_client = DummyRedis()
client = TestClient(app)


def test_user_progress_ok():
    r = client.get("/api/v1/user/progress/1")
    assert r.status_code == 200
    assert r.json()["tasks_completed"] == 5


def test_user_progress_forbidden():
    r = client.get("/api/v1/user/progress/2")
    assert r.status_code == 403


def test_leaderboard():
    r = client.get("/api/v1/leaderboard")
    assert r.status_code == 200
    data = r.json()
    assert data["user_rank"] == 3
    assert len(data["top"]) == 3


def test_admin_leaderboard():
    r = client.get("/api/v1/admin/leaderboard")
    assert r.status_code == 200
    assert len(r.json()) == 3


def test_admin_stats():
    r = client.get("/api/v1/admin/app_activity")
    assert r.status_code == 200
    assert r.json()["active_users"] == 3
