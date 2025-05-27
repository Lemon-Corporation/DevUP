# Запуск в Kubernetes

Для продакшн среды рекомендуется использовать Kubernetes, который обеспечивает масштабируемость, отказоустойчивость и более гибкое управление ресурсами.

## Предварительные требования

- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [kustomize](https://kustomize.io/)
- Доступ к Kubernetes кластеру
- [Docker](https://www.docker.com/get-started) для сборки образов

## Структура Kubernetes конфигураций

Конфигурации Kubernetes находятся в директории `k8s`:

```
k8s/
├── deployments/           # Deployments для всех сервисов
│   ├── postgres.yaml
│   ├── redis.yaml
│   ├── user-service.yaml
│   ├── theory-service.yaml
│   └── analyze-service.yaml
├── services/              # Services для всех сервисов
│   ├── postgres.yaml
│   ├── redis.yaml
│   ├── user-service.yaml
│   ├── theory-service.yaml
│   └── analyze-service.yaml
├── ingress/               # Ingress конфигурация (API Gateway)
│   └── api-gateway.yaml
├── persistent-volumes/    # Persistent Volume Claims
│   └── postgres-pvc.yaml
├── secrets/               # Секреты
│   └── db-secrets.yaml
└── kustomization.yaml     # Основной файл kustomize
```

## Подготовка образов

Перед деплоем в Kubernetes необходимо собрать Docker-образы и загрузить их в реестр, доступный вашему кластеру.

```powershell

# Публикация образов в реестр (если используется)
docker tag devup/user-service:latest your-registry.com/devup/user-service:latest
docker tag devup/theory-service:latest your-registry.com/devup/theory-service:latest
docker tag devup/analyze-service:latest your-registry.com/devup/analyze-service:latest
docker tag devup/docs-service:latest your-registry.com/devup/docs-service:latest

docker push your-registry.com/devup/user-service:latest
docker push your-registry.com/devup/theory-service:latest
docker push your-registry.com/devup/analyze-service:latest
docker push your-registry.com/devup/docs-service:latest
```

## Деплой в Kubernetes

### 1. Применение всех конфигураций

```bash
# Из корневого каталога проекта
kubectl apply -k ./k8s
```

### 2. Проверка состояния подов

```bash
kubectl get pods
```

### 3. Проверка сервисов

```bash
kubectl get services
```

### 4. Проверка Ingress

```bash
kubectl get ingress
```

## Масштабирование сервисов

Одно из преимуществ Kubernetes - простое масштабирование сервисов:

```bash
# Масштабирование UserService до 3 реплик
kubectl scale deployment user-service --replicas=3

# Масштабирование Theory Service до 2 реплик
kubectl scale deployment theory-service --replicas=2

# Масштабирование Analyze Service до 2 реплик
kubectl scale deployment analyze-service --replicas=2
```

## Обновление сервисов

После внесения изменений в код и пересборки Docker-образов:

```bash
# Обновление образа для deployment
kubectl set image deployment/user-service user-service=devup/user-service:new-tag

# Или использование Kustomize для обновления всех сервисов
kubectl apply -k ./k8s
```

## Мониторинг и логи

```bash
# Просмотр логов конкретного пода
kubectl logs pod/user-service-6b844f8b7d-xv2np

# Просмотр логов деплоймента
kubectl logs deployment/user-service
```

## Доступ к API Gateway

После успешного деплоя, API Gateway будет доступен через Ingress контроллер. URL зависит от конфигурации вашего кластера и Ingress контроллера.

Используйте следующую команду для получения IP или URL:

```bash
kubectl get ingress api-gateway
``` 


```bash
# Сборка Docker-образов для всех микросервисов
Write-Host "Building Docker images for all microservices..." -ForegroundColor Green

# UserService
Write-Host "Building UserService image..." -ForegroundColor Cyan
docker build -t devup/user-service:latest ./backend/UserService

# Theory Service
Write-Host "Building Theory Service image..." -ForegroundColor Cyan
docker build -t devup/theory-service:latest ./backend/theory_service

# Analyze Service
Write-Host "Building Analyze Service image..." -ForegroundColor Cyan
docker build -t devup/analyze-service:latest ./backend/analyze-service

# Documentation Service
Write-Host "Building Documentation Service image..." -ForegroundColor Cyan
docker build -t devup/docs-service:latest ./sdocs

Write-Host "All images built successfully!" -ForegroundColor Green

# Запуск локально через docker-compose (опционально)
$runLocally = Read-Host "Do you want to run the services locally using docker-compose? (y/n)"
if ($runLocally -eq 'y') {
    Write-Host "Starting services with docker-compose..." -ForegroundColor Cyan
    docker-compose up -d
    Write-Host "Services started! Access the API Gateway at http://localhost" -ForegroundColor Green
}

# Деплой в Kubernetes (опционально)
$deployToK8s = Read-Host "Do you want to deploy to Kubernetes? (y/n)"
if ($deployToK8s -eq 'y') {
    Write-Host "Deploying to Kubernetes..." -ForegroundColor Cyan
    
    # Применяем конфигурации Kubernetes
    kubectl apply -k ./k8s
    
    Write-Host "Waiting for services to be ready..." -ForegroundColor Yellow
    kubectl wait --for=condition=available --timeout=300s deployment/user-service deployment/theory-service deployment/analyze-service deployment/docs-service
    
    Write-Host "Deployed to Kubernetes successfully!" -ForegroundColor Green
    Write-Host "To access the API Gateway, use the Ingress IP or domain configured in your cluster" -ForegroundColor Cyan
} 
```