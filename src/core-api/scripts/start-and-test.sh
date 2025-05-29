#!/bin/bash

# Test script to verify all services start up correctly
# This script will start the services and check their health

set -e

echo "🚀 Starting UniConnect platform services..."

# Start the services in development mode
docker-compose -f docker-compose.development.yml up -d

echo "⏳ Waiting for services to start..."

# Function to check if a service is healthy
check_service_health() {
    local service_name=$1
    local url=$2
    local max_attempts=${3:-30}
    local attempt=1
    
    echo "🔍 Checking $service_name health..."
    
    while [ $attempt -le $max_attempts ]; do
        if curl -f -s "$url" > /dev/null 2>&1; then
            echo "✅ $service_name is healthy"
            return 0
        fi
        
        echo "⏳ Attempt $attempt/$max_attempts - $service_name not ready yet..."
        sleep 5
        attempt=$((attempt + 1))
    done
    
    echo "❌ $service_name failed to start within expected time"
    return 1
}

# Function to check postgres databases
check_postgres_databases() {
    echo "🔍 Checking PostgreSQL databases..."
    
    # Wait for PostgreSQL to be ready
    sleep 10
    
    # Check if both databases exist
    docker exec uniconnect-postgres psql -U uniconnect -lqt | cut -d \| -f 1 | grep -qw uniconnect
    if [ $? -eq 0 ]; then
        echo "✅ uniconnect database exists"
    else
        echo "❌ uniconnect database does not exist"
        return 1
    fi
    
    docker exec uniconnect-postgres psql -U uniconnect -lqt | cut -d \| -f 1 | grep -qw keycloak
    if [ $? -eq 0 ]; then
        echo "✅ keycloak database exists"
    else
        echo "❌ keycloak database does not exist"
        return 1
    fi
}

# Check PostgreSQL first
check_postgres_databases

# Check individual services
echo ""
echo "🔍 Checking service health endpoints..."

# PostgreSQL (check if ready)
if docker exec uniconnect-postgres pg_isready -U uniconnect > /dev/null 2>&1; then
    echo "✅ PostgreSQL is ready"
else
    echo "❌ PostgreSQL is not ready"
fi

# Redis
check_service_health "Redis" "redis://localhost:6379" 10

# MinIO
check_service_health "MinIO" "http://localhost:9000/minio/health/live" 10

# Meilisearch
check_service_health "Meilisearch" "http://localhost:7700/health" 10

# Jaeger (check if web UI is accessible)
check_service_health "Jaeger" "http://localhost:16686" 10

# Keycloak (this might take longer)
check_service_health "Keycloak" "http://localhost:8180/health/ready" 60

# API Service
check_service_health "UniConnect API" "http://localhost:8080/health" 30

echo ""
echo "🎉 All services are running!"
echo ""
echo "📋 Service URLs:"
echo "   • API: http://localhost:8080"
echo "   • API Health: http://localhost:8080/health"
echo "   • Swagger: http://localhost:8080/swagger"
echo "   • PostgreSQL: localhost:5432"
echo "   • Redis: localhost:6379"
echo "   • MinIO Console: http://localhost:9001"
echo "   • MailHog: http://localhost:8025"
echo "   • Meilisearch: http://localhost:7700"
echo "   • Jaeger: http://localhost:16686"
echo "   • Keycloak: http://localhost:8180"
echo ""
echo "🔐 Default credentials:"
echo "   • MinIO: minioadmin / minioadmin"
echo "   • Keycloak Admin: admin / admin"
echo "   • PostgreSQL: uniconnect / uniconnect_password"
