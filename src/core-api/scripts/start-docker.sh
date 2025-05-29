#!/bin/bash

# Function to check if a service is ready
check_service() {
  local service=$1
  local max_attempts=$2
  local attempt=1
  
  echo "Checking if $service is ready..."
  
  while [ $attempt -le $max_attempts ]; do
    if docker compose -f ../docker-compose.yml ps $service | grep -q "running"; then
      echo "✅ $service is running."
      return 0
    else
      echo "⏳ Waiting for $service to start (attempt $attempt/$max_attempts)..."
      sleep 5
      ((attempt++))
    fi
  done
  
  echo "❌ ERROR: $service didn't start properly!"
  return 1
}

# Build and start the Docker containers
echo "🚀 Starting UniConnect environment with Docker Compose..."
docker compose -f ../docker-compose.yml up -d

# Wait for core services to be ready
echo "⏳ Checking service readiness..."
check_service postgres 12
check_service redis 6
check_service meilisearch 10
check_service jaeger 6
check_service keycloak 15
check_service uniconnect-api 10

# Display the status of all containers
echo "📊 Container Status:"
docker compose -f ../docker-compose.yml ps

echo "----------------------------------------------------"
echo "UniConnect API: http://localhost:8080"
echo "MinIO Console: http://localhost:9001"
echo "    Username: minioadmin"
echo "    Password: minioadmin"
echo "MailHog UI:   http://localhost:8025"
echo "----------------------------------------------------"
echo "PostgreSQL: localhost:5432"
echo "    Database: uniconnect"
echo "    Username: uniconnect"
echo "    Password: uniconnect_password"
echo "----------------------------------------------------"
