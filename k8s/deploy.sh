#!/bin/bash

echo -e "\e[32mСборка Docker-образов для всех микросервисов...\e[0m"

# UserService
echo -e "\e[36mСборка UserService...\e[0m"
docker build -t devup/user-service:latest ./backend/UserService

# Theory Service
echo -e "\e[36mСборка Theory Service...\e[0m"
docker build -t devup/theory-service:latest ./backend/theory_service

# Analyze Service
echo -e "\e[36mСборка Analyze Service...\e[0m"
docker build -t devup/analyze-service:latest ./backend/analyze-service

# Documentation Service
echo -e "\e[36mСборка Documentation Service...\e[0m"
docker build -t devup/docs-service:latest ./sdocs

echo -e "\e[32mВсе образы успешно собраны!\e[0m"

# Запуск через docker-compose
read -p "Запустить сервисы локально через docker-compose? (y/n): " runLocally
if [[ "$runLocally" == "y" ]]; then
    echo -e "\e[36mЗапуск docker-compose...\e[0m"
    docker-compose up -d
    echo -e "\e[32mСервисы запущены! Открой http://localhost\e[0m"
fi

# Деплой в Kubernetes
read -p "Выполнить деплой в Kubernetes? (y/n): " deployToK8s
if [[ "$deployToK8s" == "y" ]]; then
    echo -e "\e[36mДеплой в Kubernetes...\e[0m"
    kubectl apply -k ./k8s

    echo -e "\e[33mОжидание готовности подов...\e[0m"
    kubectl wait --for=condition=available --timeout=300s \
        deployment/user-service \
        deployment/theory-service \
        deployment/analyze-service \
        deployment/docs-service

    echo -e "\e[32mУспешно задеплоено в Kubernetes!\e[0m"
    echo -e "\e[36mДля доступа используй Ingress IP или домен из конфигурации кластера\e[0m"
fi
