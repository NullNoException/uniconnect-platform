#!/bin/bash

# Function to check if a service is ready
check_service() {
  local service=$1
  local max_attempts=$2
  local attempt=1
  
  echo "Checking if $service is ready..."
  
  while [ $attempt -le $max_attempts ]; do
    if docker compose -f ../docker-compose.development.yml ps $service | grep -q "running"; then
      echo "$service is running."
      return 0
    else
      echo "Waiting for $service to start (attempt $attempt/$max_attempts)..."
      sleep 5
      ((attempt++))
    fi
  done
  
  echo "ERROR: $service didn't start properly!"
  return 1
}

# Start the containers in development mode
echo "Starting development containers..."
docker compose -f ../docker-compose.development.yml up -d --build

# Wait for core services to be ready
check_service postgres 12
check_service redis 6
check_service meilisearch 10
check_service jaeger 6
check_service keycloak 15
check_service uniconnect-api 10

# Add additional waiting time for services that don't have proper health checks
echo "Allowing additional time for services to initialize..."
sleep 10

echo "====== Checking container directory structure ======"
docker exec uniconnect-api ls -la /app
echo "====== Checking API project folder ======"
docker exec uniconnect-api ls -la /app/src
echo "====== Checking API project folder contents ======"
docker exec uniconnect-api ls -la /app/src/UniConnect.API
echo "====== Trying to find project files ======"
docker exec uniconnect-api find /app -name "*.csproj"
echo "====== Checking current working directory ======"
docker exec uniconnect-api pwd
echo "====== Checking .NET SDK version ======"
docker exec uniconnect-api dotnet --version

echo "====== Container logs ======"
docker logs uniconnect-api
