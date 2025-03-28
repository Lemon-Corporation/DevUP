from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    """
    Класс настроек приложения, загружаемых из файла .env.
    """
    POSTGRES_DSN: str
    REDIS_DSN: str
    SERVICE_HOST: str
    SERVICE_PORT: int
    SECRET_KEY: str

    class Config:
        env_file = ".env"


settings = Settings()
