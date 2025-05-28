#!/bin/bash

# Color codes for prettier output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Test service API endpoint
test_service_endpoint() {
    local service_name=$1
    local endpoint=$2
    local expected_status=$3
    local max_attempts=$4
    local attempt=1

    echo -e "${BLUE}Testing ${service_name} API at ${endpoint}...${NC}"
    
    while [ $attempt -le $max_attempts ]; do
        status_code=$(curl -s -o /dev/null -w "%{http_code}" "$endpoint")
        
        if [ "$status_code" == "$expected_status" ]; then
            echo -e "${GREEN}✅ ${service_name} API is responding with status ${status_code} as expected.${NC}"
            return 0
        else
            echo -e "${YELLOW}⏳ Attempt ${attempt}/${max_attempts}: ${service_name} API returned ${status_code}, expected ${expected_status}. Retrying...${NC}"
            sleep 2
            ((attempt++))
        fi
    done
    
    echo -e "${RED}❌ ${service_name} API failed to respond correctly after ${max_attempts} attempts.${NC}"
    return 1
}

# Check if a Docker container is running and healthy
check_container_health() {
    local container_name=$1
    local docker_compose_file=$2
    
    echo -e "${BLUE}Checking container: ${container_name}...${NC}"
    
    # Check if container exists
    if ! docker ps -a --format "{{.Names}}" | grep -q "^${container_name}$"; then
        echo -e "${RED}❌ Container ${container_name} does not exist!${NC}"
        return 1
    fi
    
    # Check container status
    container_status=$(docker inspect --format='{{.State.Status}}' "${container_name}")
    
    if [ "$container_status" != "running" ]; then
        echo -e "${RED}❌ Container ${container_name} is not running (status: ${container_status})${NC}"
        docker logs "${container_name}" --tail 20
        return 1
    fi
    
    # Check health status if available
    health_status=$(docker inspect --format='{{if .State.Health}}{{.State.Health.Status}}{{else}}no-healthcheck{{end}}' "${container_name}")
    
    if [ "$health_status" == "healthy" ]; then
        echo -e "${GREEN}✅ Container ${container_name} is running and healthy!${NC}"
        return 0
    elif [ "$health_status" == "no-healthcheck" ]; then
        echo -e "${GREEN}✅ Container ${container_name} is running! (No health check defined)${NC}"
        return 0
    else
        echo -e "${YELLOW}⚠️ Container ${container_name} health status: ${health_status}${NC}"
        echo -e "${YELLOW}Recent logs:${NC}"
        docker logs "${container_name}" --tail 10
        return 1
    fi
}

# Determine which docker-compose file to use
if [ "$1" == "dev" ] || [ "$1" == "development" ]; then
    COMPOSE_FILE="../docker-compose.development.yml"
    echo -e "${BLUE}Using development docker-compose file${NC}"
else
    COMPOSE_FILE="../docker-compose.yml"
    echo -e "${BLUE}Using production docker-compose file${NC}"
fi

# Check all containers
echo -e "${BLUE}=== Checking Container Status ===${NC}"
check_container_health "uniconnect-postgres" "$COMPOSE_FILE"
check_container_health "uniconnect-redis" "$COMPOSE_FILE"
check_container_health "uniconnect-minio" "$COMPOSE_FILE"
check_container_health "uniconnect-elasticsearch" "$COMPOSE_FILE"
check_container_health "uniconnect-meilisearch" "$COMPOSE_FILE"
check_container_health "uniconnect-jaeger" "$COMPOSE_FILE"
check_container_health "uniconnect-keycloak" "$COMPOSE_FILE"
check_container_health "uniconnect-api" "$COMPOSE_FILE"
check_container_health "uniconnect-mailhog" "$COMPOSE_FILE"

# Test service endpoints
echo -e "${BLUE}=== Testing Service Endpoints ===${NC}"
test_service_endpoint "API Health" "http://localhost:8080/health" "200" 5
test_service_endpoint "Elasticsearch" "http://localhost:9200/_cluster/health" "200" 5
test_service_endpoint "Meilisearch" "http://localhost:7700/health" "200" 5
test_service_endpoint "Minio" "http://localhost:9000/minio/health/live" "200" 5
test_service_endpoint "Keycloak" "http://localhost:8180/health/ready" "200" 5
test_service_endpoint "Jaeger UI" "http://localhost:16686" "200" 3

echo -e "${BLUE}=== Additional Service Information ===${NC}"
echo -e "${BLUE}Jaeger UI:${NC} http://localhost:16686"
echo -e "${BLUE}Meilisearch:${NC} http://localhost:7700"
echo -e "${BLUE}Minio Console:${NC} http://localhost:9001 (User: minioadmin, Password: minioadmin)"
echo -e "${BLUE}Keycloak Admin:${NC} http://localhost:8180/admin/ (User: admin, Password: admin)"
echo -e "${BLUE}Mailhog UI:${NC} http://localhost:8025"
echo -e "${BLUE}API Swagger:${NC} http://localhost:8080/swagger"

echo -e "${GREEN}✅ Service verification complete!${NC}"
