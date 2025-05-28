from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    """Конфигурация приложения."""
    POSTGRES_DSN: str
    REDIS_DSN: str
    SERVICE_HOST: str = "0.0.0.0"
    SERVICE_PORT: int = 8000
    SECRET_KEY: str
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 60

    class Config:
        env_file = ".env"


settings = Settings()
