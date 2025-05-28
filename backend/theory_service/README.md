# Theory Service

## Описание
Микросервис для хранения и получения теоретических материалов.

## Возможности
- Хранение теоретических материалов в PostgreSQL
- Валидация и сериализация данных через Marshmallow
- Swagger UI по адресу `/docs`
- Пагинация (`limit`, `offset`)
- Глобальная обработка ошибок (400, 404, 500)
- Healthcheck эндпоинт `/api/v1/theory/health`
- Docker-окружение

## Структура проекта
```
app/
  __init__.py
  db.py
  models.py
  routes.py
  seed.py
  services/
    theory_service.py
  schemas/
    theory.py
  utils/
migrations/
tests/
  test_theory.py
requirements.txt
Dockerfile
docker-compose.yml
README.md
config.py
run.py
```

## Запуск

1. Установить зависимости:
   ```
   pip install -r requirements.txt
   ```

2. Создать файл `.env` на основе `.env.example` и указать параметры подключения к PostgreSQL.

3. Инициализировать миграции:
   ```
   flask db init
   flask db migrate -m "init"
   flask db upgrade
   ```

4. Наполнить тестовыми данными:
   ```
   python app/seed.py
   ```

5. Запустить сервис:
   ```
   python run.py
   ```

## Запуск через Docker

1. Собрать и запустить:
   ```
   docker-compose up --build
   ```

2. Применить миграции:
   ```
   docker-compose exec theory_service flask db upgrade
   ```

3. Засеять тестовые данные:
   ```
   docker-compose exec theory_service python -m app.seed
   ```

## Эндпоинты

- `GET /api/v1/theory?topic=algorithms&level=junior&limit=10&offset=0` — список материалов с фильтрацией и пагинацией
- `GET /api/v1/theory/<theoryId>` — получить материал по ID
- `GET /api/v1/theory/health` — healthcheck

## Примеры ошибок
- 400: `{ "error": "Bad request", "message": "limit must be between 1 and 100" }`
- 404: `{ "error": "Not found", "message": "Theory not found" }`
- 500: `{ "error": "Internal server error", "message": "..." }`

## Swagger UI
- [http://localhost:5000/docs](http://localhost:5000/docs)

## Пример запроса
```
curl "http://localhost:5000/api/v1/theory?topic=algorithms&limit=2"
``` 