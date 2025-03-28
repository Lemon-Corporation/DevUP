import asyncpg

async def init_db_pool(dsn: str) -> asyncpg.Pool:
    """
    Создает пул подключений к PostgreSQL.
    """
    return await asyncpg.create_pool(dsn=dsn, min_size=1, max_size=10)

async def init_db(pool: asyncpg.Pool):
    """
    Инициализирует схему БД, создавая необходимые таблицы, если их нет.
    """
    async with pool.acquire() as conn:
        # Таблица для хранения теоретических материалов
        await conn.execute("""
            CREATE TABLE IF NOT EXISTS theory_materials (
                id SERIAL PRIMARY KEY,
                title TEXT NOT NULL,
                content TEXT NOT NULL
            );
        """)
