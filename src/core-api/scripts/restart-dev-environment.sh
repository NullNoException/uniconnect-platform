#!/bin/bash

# Function to check if a service is ready
check_service() {
  local service=$1
  local max_attempts=$2
  local attempt=1
  
  echo "Checking if $service is ready..."
  
  while [ $attempt -le $max_attempts ]; do
    if docker compose -f ../docker-compose.development.yml ps $service | grep -q "running"; then
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

echo "🛑 Stopping existing containers..."
docker compose -f ../docker-compose.development.yml down

echo "🔨 Building and starting containers with the new configuration..."
docker compose -f ../docker-compose.development.yml build
docker compose -f ../docker-compose.development.yml up -d

# Check core services
echo "⏳ Checking service readiness..."
check_service postgres 10
check_service redis 5
check_service meilisearch 8
check_service jaeger 5
check_service keycloak 12
check_service uniconnect-api 8

echo "📋 Checking logs for uniconnect-api container..."
docker logs uniconnect-api --tail 50

echo "Test your VS Code debugger connection now by setting a breakpoint and starting the debugging session"
echo "If there are any issues, run ./debug-container.sh to get more diagnostics"
