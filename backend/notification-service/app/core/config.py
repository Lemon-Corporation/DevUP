from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    """Загружает env-vars в атрибуты."""
    POSTGRES_DSN: str
    REDIS_DSN: str
    SERVICE_HOST: str = "0.0.0.0"
    SERVICE_PORT: int = 8000
    SECRET_KEY: str
    ADMIN_TOKEN: str
    CACHE_EXPIRE: int = 60

    class Config:
        env_file = ".env"
        env_file_encoding = "utf-8"


settings = Settings()
