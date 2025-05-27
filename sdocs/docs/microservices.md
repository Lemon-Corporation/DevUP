# Микросервисы

## UserService

**Технологии**: Java 17, Spring Boot 3.4, Spring Security, JWT, PostgreSQL

**Описание**: Сервис для управления пользователями, аутентификации и авторизации.

### Основные функции:

- Регистрация и аутентификация пользователей
- Управление профилями пользователей
- Генерация и проверка JWT токенов
- Управление ролями и правами доступа

### API endpoints:

```
POST   /api/users/register         # Регистрация нового пользователя
POST   /api/users/login            # Аутентификация и получение токена
GET    /api/users/profile          # Получение профиля текущего пользователя
PUT    /api/users/profile          # Обновление профиля пользователя
GET    /api/users/{id}             # Получение информации о пользователе по ID
GET    /api/users/health           # Проверка работоспособности сервиса
```

### Dockerfile:

```dockerfile
FROM maven:3.8.4-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -B
COPY src ./src/
RUN mvn package -Dmaven.test.skip=true

FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
```

## Theory Service

**Технологии**: Python 3.11, Flask, PostgreSQL

**Описание**: Сервис для управления теоретическими материалами обучения.

### Основные функции:

- Создание и редактирование учебных курсов
- Управление разделами и главами
- Отслеживание прогресса обучения
- Тестирование знаний

### API endpoints:

```
GET    /api/theory/courses             # Список всех курсов
GET    /api/theory/courses/{id}        # Информация о конкретном курсе
POST   /api/theory/courses             # Создание нового курса
PUT    /api/theory/courses/{id}        # Обновление курса
GET    /api/theory/progress/{user_id}  # Прогресс пользователя
POST   /api/theory/progress            # Обновление прогресса
GET    /api/theory/health              # Проверка работоспособности сервиса
```

### Dockerfile:

```dockerfile
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV FLASK_APP=run.py
ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_ENV=development

CMD ["flask", "run"]
```

## Analyze Service

**Технологии**: Python 3.11, FastAPI, PostgreSQL, Redis

**Описание**: Сервис для аналитики и сбора статистики.

### Основные функции:

- Сбор и анализ данных о прогрессе пользователей
- Формирование отчетов и рекомендаций
- Расчет рейтингов и лидерборда
- Анализ эффективности обучения

### API endpoints:

```
GET    /api/v1/stats/users            # Статистика по пользователям
GET    /api/v1/stats/courses          # Статистика по курсам
GET    /api/v1/leaderboard            # Лидерборд пользователей
GET    /api/v1/recommendations/{id}   # Рекомендации для пользователя
GET    /api/v1/health                 # Проверка работоспособности сервиса
```

### Dockerfile:

```dockerfile
FROM python:3.11 AS build
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

FROM python:3.11
WORKDIR /app
COPY --from=build /usr/local /usr/local
ENV PATH="/usr/local/bin:$PATH"
COPY app/ app/
RUN touch .env
USER nobody
EXPOSE 8000
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
```

## Documentation Service

**Технологии**: Python 3.11, FastAPI, Jinja2, Markdown

**Описание**: Сервис для отображения документации проекта.

### Основные функции:

- Отображение документации в формате Markdown
- Навигация по разделам документации
- Поиск по документации

### API endpoints:

```
GET    /                # Главная страница документации
GET    /docs/{path}     # Отображение определенного раздела документации
GET    /health          # Проверка работоспособности сервиса
```

### Dockerfile:

```dockerfile
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8090

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8090"]
``` 