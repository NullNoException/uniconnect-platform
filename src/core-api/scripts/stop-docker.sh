#!/bin/bash

# Stop Docker containers
echo "🛑 Stopping UniConnect environment..."

# Determine which docker-compose files to stop
if [ "$1" == "all" ]; then
    echo "Stopping both production and development environments..."
    docker compose -f ../docker-compose.yml down
    docker compose -f ../docker-compose.development.yml down
elif [ "$1" == "dev" ] || [ "$1" == "development" ]; then
    echo "Stopping development environment only..."
    docker compose -f ../docker-compose.development.yml down
else
    echo "Stopping production environment only..."
    docker compose -f ../docker-compose.yml down
fi

echo "✅ Environment stopped."
echo "💡 To stop all environments, use: ./stop-docker.sh all"
