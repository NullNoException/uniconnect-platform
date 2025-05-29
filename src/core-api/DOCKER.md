# Running UniConnect with Docker

This guide explains how to run the UniConnect Core API using Docker and Docker Compose.

## Prerequisites

- Docker and Docker Compose installed on your machine
- Git (to clone the repository)

## Available Docker Configurations

UniConnect provides two Docker Compose configurations:

1. **Production-like Environment** (`docker-compose.yml`): Standard configuration for running the application
2. **Development Environment** (`docker-compose.development.yml`): Includes hot-reload and debugger support

## Getting Started

1. Clone the repository (if you haven't already):

```bash
git clone <repository-url>
cd core-api
```

2. Start the application using the provided scripts:

```bash
# Production-like environment
cd scripts
./start-docker.sh

# Development environment with debugging
cd scripts
./debug-container.sh
```

3. Verify all services are running properly:

```bash
cd scripts
./check-services.sh        # For production environment
./check-services.sh dev    # For development environment
```

This setup will start the following services:

| Service        | Description      | Port(s)                    | URL                    |
| -------------- | ---------------- | -------------------------- | ---------------------- |
| UniConnect API | ASP.NET Core API | 8080 (HTTP), 8443 (HTTPS)  | http://localhost:8080  |
| PostgreSQL     | Database         | 5432                       | -                      |
| Redis          | Cache            | 6379                       | -                      |
| Minio          | Object Storage   | 9000 (API), 9001 (Console) | http://localhost:9001  |
| Meilisearch    | Search Engine    | 7700                       | http://localhost:7700  |
| Jaeger         | Tracing          | 16686 (UI), various        | http://localhost:16686 |
| Keycloak       | Authentication   | 8180                       | http://localhost:8180  |
| MailHog        | Email Testing    | 1025 (SMTP), 8025 (UI)     | http://localhost:8025  |

4. Access the API Swagger documentation:

Open your browser and navigate to [http://localhost:8080/swagger](http://localhost:8080/swagger)

5. Check service status:

```bash
cd scripts
./check-services.sh
```

## Configuration

The services are configured through environment variables in the docker-compose.yml file. For development, default credentials are used, but in production, you should change these values.

## Useful Commands

- Stop all services:

  ```bash
  ./stop-docker.sh
  ```

  Or manually with:

  ```bash
  docker-compose down
  ```

- View logs:

  ```bash
  docker-compose logs -f
  ```

- View logs for a specific service:

  ```bash
  docker-compose logs -f uniconnect-api
  ```

- Rebuild the API:

  ```bash
  docker-compose build uniconnect-api
  ```

- Access PostgreSQL:
  ```bash
  docker exec -it uniconnect-postgres psql -U uniconnect -d uniconnect
  ```

## Data Persistence

The following Docker volumes are used to persist data:

- postgres_data: PostgreSQL database
- redis_data: Redis data
- minio_data: MinIO object storage

These volumes ensure that your data is preserved between container restarts.
