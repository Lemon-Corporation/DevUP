import os


class Config:
    SQLALCHEMY_DATABASE_URI = os.getenv(
        "DATABASE_URL", "postgresql://postgres:postgres@localhost:5432/theory_service"
    )
    SQLALCHEMY_TRACK_MODIFICATIONS = False
