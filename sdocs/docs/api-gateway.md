# API Gateway

API Gateway является единой точкой входа для всех внешних запросов к микросервисам. Он выполняет функции маршрутизации, балансировки нагрузки и обработки CORS заголовков.

## Маршрутизация запросов

### Схема маршрутизации

API Gateway маршрутизирует запросы на основе префикса URL:

| Префикс URL  | Микросервис           | Описание                        |
|--------------|------------------------|--------------------------------|
| `/api/users` | UserService           | Управление пользователями       |
| `/api/theory`| Theory Service        | Управление учебными материалами |
| `/api/v1`    | Analyze Service       | Аналитика и статистика         |
| `/docs`      | Documentation Service | Документация проекта           |

## Конфигурация CORS

API Gateway настроен для поддержки CORS запросов с любых источников, что позволяет фронтенду взаимодействовать с API без проблем.

### Nginx конфигурация

Конфигурация API Gateway на базе Nginx:

```nginx
server {
    listen 80;

    # Настройка CORS
    add_header 'Access-Control-Allow-Origin' '*' always;
    add_header 'Access-Control-Allow-Methods' 'GET, POST, PUT, DELETE, OPTIONS' always;
    add_header 'Access-Control-Allow-Headers' 'Origin, X-Requested-With, Content-Type, Accept, Authorization' always;
    add_header 'Access-Control-Allow-Credentials' 'true' always;

    # Обработка OPTIONS запросов для CORS preflight
    if ($request_method = 'OPTIONS') {
        add_header 'Access-Control-Allow-Origin' '*';
        add_header 'Access-Control-Allow-Methods' 'GET, POST, PUT, DELETE, OPTIONS';
        add_header 'Access-Control-Allow-Headers' 'Origin, X-Requested-With, Content-Type, Accept, Authorization';
        add_header 'Access-Control-Allow-Credentials' 'true';
        add_header 'Content-Type' 'text/plain charset=UTF-8';
        add_header 'Content-Length' 0;
        return 204;
    }

    # Маршрутизация для UserService
    location /api/users {
        proxy_pass http://user-service:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }

    # Маршрутизация для теории
    location /api/theory {
        proxy_pass http://theory-service:5000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }

    # Маршрутизация для аналитики
    location /api/v1 {
        proxy_pass http://analyze-service:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }

    # Маршрутизация для документации
    location /docs {
        proxy_pass http://docs-service:8090;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }

    # Дефолтный маршрут для админки
    location / {
        return 200 'API Gateway is running';
    }
}
```

### Kubernetes Ingress

Для Kubernetes используется Ingress:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: api-gateway
  annotations:
    nginx.ingress.kubernetes.io/enable-cors: "true"
    nginx.ingress.kubernetes.io/cors-allow-origin: "*"
    nginx.ingress.kubernetes.io/cors-allow-methods: "GET, POST, PUT, DELETE, OPTIONS"
    nginx.ingress.kubernetes.io/cors-allow-headers: "Origin, X-Requested-With, Content-Type, Accept, Authorization"
    nginx.ingress.kubernetes.io/cors-allow-credentials: "true"
spec:
  ingressClassName: nginx
  rules:
  - http:
      paths:
      - path: /api/users
        pathType: Prefix
        backend:
          service:
            name: user-service
            port:
              number: 8080
      - path: /api/theory
        pathType: Prefix
        backend:
          service:
            name: theory-service
            port:
              number: 5000
      - path: /api/v1
        pathType: Prefix
        backend:
          service:
            name: analyze-service
            port:
              number: 8000
      - path: /docs
        pathType: Prefix
        backend:
          service:
            name: docs-service
            port:
              number: 8090
```

## Проверка CORS

Для проверки CORS заголовков можно использовать OPTIONS запрос:

```bash
curl -X OPTIONS -v http://localhost
```

Или с помощью скрипта `check-services.ps1`:

```powershell
./check-services.ps1
``` 