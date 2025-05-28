# Kubernetes Configuration for DevUP

This directory contains Kubernetes configurations for deploying the DevUP application.

## Structure

- `deployments/` - Deployment configurations for all services
- `services/` - Service configurations for all services
- `ingress/` - API Gateway configuration (Ingress)
- `persistent-volumes/` - Persistent volume claims
- `secrets/` - Secret configurations
- `kustomization.yaml` - Main kustomization file for easy deployment

## Deployment

To deploy all components, use:

```bash
kubectl apply -k .
```

## Components

### Microservices

- **user-service** - User management service (Java/Spring Boot)
- **theory-service** - Theory content service (Python/Flask)
- **analyze-service** - Analytics service (Python/FastAPI)

### Infrastructure

- **postgres** - PostgreSQL database
- **redis** - Redis cache
- **api-gateway** - Nginx-based API Gateway (Ingress)

## API Routes

The API Gateway routes requests to the appropriate microservice:

- `/api/users/*` → user-service
- `/api/theory/*` → theory-service
- `/api/v1/*` → analyze-service

## CORS Configuration

All services are configured to accept CORS requests from any origin. This is set up in the Ingress controller through annotations. 