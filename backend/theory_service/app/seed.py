from app import create_app
from app.db import db
from app.models import Theory

app = create_app()
app.app_context().push()


def seed():
    db.session.add_all(
        [
            Theory(
                topic="algorithms",
                level="junior",
                title="Сортировка пузырьком",
                content="Описание алгоритма сортировки пузырьком...",
            ),
            Theory(
                topic="databases",
                level="middle",
                title="Индексы в PostgreSQL",
                content="Описание индексов в PostgreSQL...",
            ),
        ]
    )
    db.session.commit()
    print("Test data added.")


if __name__ == "__main__":
    seed()
