#!/bin/bash

# Start the containers in development mode
docker compose -f docker-compose.development.yml up -d --build

# Wait for the container to start
sleep 5

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
