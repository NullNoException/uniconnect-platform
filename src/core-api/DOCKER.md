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

| Service | Description | Port(s) | URL |
|---------|-------------|---------|-----|
| UniConnect API | ASP.NET Core API | 8080 (HTTP), 8443 (HTTPS) | http://localhost:8080 |
| PostgreSQL | Database | 5432 | - |
| Redis | Cache | 6379 | - |
| Minio | Object Storage | 9000 (API), 9001 (Console) | http://localhost:9001 |
| Elasticsearch | Search Engine | 9200, 9300 | http://localhost:9200 |
| Meilisearch | Search Engine | 7700 | http://localhost:7700 |
| Jaeger | Tracing | 16686 (UI), various | http://localhost:16686 |
| Keycloak | Authentication | 8180 | http://localhost:8180 |
| MailHog | Email Testing | 1025 (SMTP), 8025 (UI) | http://localhost:8025 |

4. Access the API Swagger documentation:

Open your browser and navigate to [http://localhost:8080/swagger](http://localhost:8080/swagger)

5. Check service status:

```bash
cd scripts
./check-services.sh
```

## Configuration

The services are configured through environment variables in the Docker Compose files. For development, default credentials are used, but in production, you should change these values.

## Debugging

The application can be debugged remotely:

1. Start the development environment: 
```bash
cd scripts
./debug-container.sh
```

2. In VS Code, use the ".NET Core Attach" configuration
3. Select the process to debug (usually `dotnet exec /app/.../UniConnect.API.dll`)

## Available Scripts

All scripts are located in the `scripts/` directory:

| Script | Description |
|--------|-------------|
| `start-docker.sh` | Starts the production-like environment |
| `stop-docker.sh` | Stops Docker environments (`all`, `dev`, or default) |
| `debug-container.sh` | Starts the development environment with debugging support |
| `restart-dev-environment.sh` | Restarts the development environment |
| `check-services.sh` | Verifies all services are running properly |

## Useful Commands

- Stop all services:

  ```bash
  cd scripts
  ./stop-docker.sh all  # Stops both environments
  ./stop-docker.sh      # Stops production environment only
  ./stop-docker.sh dev  # Stops development environment only
  ```

- View logs:

  ```bash
  docker compose -f docker-compose.yml logs -f
  ```

- View logs for a specific service:

  ```bash
  docker logs -f uniconnect-api
  ```

- Rebuild the API:

  ```bash
  docker compose -f docker-compose.yml build uniconnect-api
  ```

- Access PostgreSQL:
  ```bash
  docker exec -it uniconnect-postgres psql -U uniconnect -d uniconnect
  ```

## Service Administration

- **Keycloak Admin Console**: http://localhost:8180/admin/ 
  - Username: admin
  - Password: admin

- **Minio Console**: http://localhost:9001
  - Username: minioadmin
  - Password: minioadmin
  
- **Jaeger UI**: http://localhost:16686
  - For viewing distributed traces

- **MailHog**: http://localhost:8025
  - For testing email functionality

## Data Persistence

The following Docker volumes are used to persist data:

| Volume | Service | Purpose |
|--------|---------|---------|
| postgres_data | PostgreSQL | Database files |
| redis_data | Redis | Cache data |
| minio_data | MinIO | Object storage |
| elasticsearch_data | Elasticsearch | Search index data |
| meilisearch_data | Meilisearch | Search index data |

These volumes ensure that your data is preserved between container restarts.

## Troubleshooting

If services aren't initializing properly:

1. Check the service's health status:
   ```bash
   ./check-services.sh
   ```

2. View specific service logs:
   ```bash
   docker logs uniconnect-[service-name]
   ```

3. Restart specific services:
   ```bash
   docker compose -f docker-compose.yml restart [service-name]
   ```

4. For a complete reset, stop and restart all services:
   ```bash
   ./stop-docker.sh all && ./start-docker.sh
   ```
