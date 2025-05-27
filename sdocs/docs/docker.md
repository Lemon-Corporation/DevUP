# Запуск с Docker Compose

Docker Compose позволяет легко запустить все сервисы локально для разработки и тестирования.

## Предварительные требования

- [Docker](https://www.docker.com/get-started)
- [Docker Compose](https://docs.docker.com/compose/install/)
- Не менее 4 ГБ свободной оперативной памяти
- Не менее 10 ГБ свободного места на диске

## Структура docker-compose.yml

Файл `docker-compose.yml` содержит конфигурацию для всех сервисов:

```yaml
version: '3.8'

services:
  postgres:
    image: postgres:14
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
      POSTGRES_DB: devup
    volumes:
      - postgres-data:/var/lib/postgresql/data
    ports:
      - "5432:5432"
    networks:
      - devup-network

  redis:
    image: redis:7
    ports:
      - "6379:6379"
    networks:
      - devup-network

  user-service:
    build:
      context: ./backend/UserService
    ports:
      - "8081:8080"
    environment:
      SPRING_DATASOURCE_URL: jdbc:postgresql://postgres:5432/devup
      SPRING_DATASOURCE_USERNAME: postgres
      SPRING_DATASOURCE_PASSWORD: postgres
      SPRING_JPA_HIBERNATE_DDL_AUTO: update
    depends_on:
      - postgres
    networks:
      - devup-network

  theory-service:
    build:
      context: ./backend/theory_service
    ports:
      - "5000:5000"
    environment:
      DATABASE_URI: postgresql://postgres:postgres@postgres:5432/devup
      FLASK_RUN_HOST: 0.0.0.0
    depends_on:
      - postgres
    networks:
      - devup-network

  analyze-service:
    build:
      context: ./backend/analyze-service
    ports:
      - "8000:8000"
    environment:
      POSTGRES_DSN: postgresql+asyncpg://postgres:postgres@postgres:5432/devup
      REDIS_DSN: redis://redis:6379/0
    depends_on:
      - postgres
      - redis
    networks:
      - devup-network

  api-gateway:
    image: nginx:1.23
    ports:
      - "80:80"
    volumes:
      - ./nginx.conf:/etc/nginx/conf.d/default.conf
    depends_on:
      - user-service
      - theory-service
      - analyze-service
    networks:
      - devup-network

  docs-service:
    build:
      context: ./sdocs
    ports:
      - "8090:8090"
    networks:
      - devup-network

networks:
  devup-network:
    driver: bridge

volumes:
  postgres-data:
```

## Команды для запуска

### Сборка образов

```bash
docker-compose build
```

### Запуск сервисов

```bash
docker-compose up -d
```

### Проверка статуса сервисов

```bash
docker-compose ps
```

### Просмотр логов

```bash
# Все логи
docker-compose logs

# Логи конкретного сервиса
docker-compose logs user-service
```

### Остановка сервисов

```bash
docker-compose down
```

### Перезапуск одного сервиса

```bash
docker-compose restart user-service
```

## Доступ к сервисам

После запуска, сервисы будут доступны по следующим адресам:

- **API Gateway**: http://localhost
- **Документация**: http://localhost:8090
- **UserService**: http://localhost:8081 (прямой доступ)
- **Theory Service**: http://localhost:5000 (прямой доступ)
- **Analyze Service**: http://localhost:8000 (прямой доступ)
- **PostgreSQL**: localhost:5432
- **Redis**: localhost:6379

## Проверка работоспособности

Вы можете проверить работоспособность сервисов с помощью скрипта `check-services.ps1`:

```powershell
./check-services.ps1
``` 