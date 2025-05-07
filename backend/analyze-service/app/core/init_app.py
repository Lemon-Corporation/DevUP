import asyncpg


async def init_db_pool(dsn: str) -> asyncpg.Pool:
    """
    Создает пул подключений к PostgreSQL.

    Args:
        dsn (str): строка подключения.

    Returns:
        asyncpg.Pool: пул подключений.
    """
    return await asyncpg.create_pool(dsn=dsn, min_size=1, max_size=10)


async def init_db(pool: asyncpg.Pool):
    """
    Инициализирует схему БД при старте:
    - Таблица user_progress
    - Таблица global_stats

    Args:
        pool (asyncpg.Pool): пул подключений.
    """
    async with pool.acquire() as conn:
        await conn.execute("""
            CREATE TABLE IF NOT EXISTS user_progress (
                user_id INT PRIMARY KEY,
                tasks_completed INT DEFAULT 0
            );
        """)
        await conn.execute("""
            CREATE TABLE IF NOT EXISTS global_stats (
                id SERIAL PRIMARY KEY,
                total_users INT DEFAULT 0,
                total_tasks_completed INT DEFAULT 0
            );
        """)
        row = await conn.fetchrow("SELECT COUNT(*) AS cnt FROM global_stats;")
        if row["cnt"] == 0:
            await conn.execute(
                "INSERT INTO global_stats (total_users, total_tasks_completed) VALUES (0, 0);"
            )
