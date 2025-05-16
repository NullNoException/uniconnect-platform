#!/bin/bash

# Build and start the Docker containers
echo "Starting UniConnect environment with Docker Compose..."
docker-compose up -d

# Wait for all services to be ready
echo "Waiting for services to be ready..."
sleep 10

# Display the status of all containers
echo "Container Status:"
docker-compose ps

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
