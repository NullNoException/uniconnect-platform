#!/bin/bash

echo "Stopping existing containers..."
docker compose -f docker-compose.development.yml down

echo "Building and starting containers with the new configuration..."
docker compose -f docker-compose.development.yml build
docker compose -f docker-compose.development.yml up -d

echo "Waiting for containers to start..."
sleep 5

echo "Checking logs for uniconnect-api container..."
docker logs uniconnect-api

echo "Test your VS Code debugger connection now by setting a breakpoint and starting the debugging session"
echo "If there are any issues, run ./debug-container.sh to get more diagnostics"
