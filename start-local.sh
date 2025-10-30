#!/bin/bash

# Script to start the local development environment
echo "🚀 Starting local development environment..."

# Check .env file
if [ ! -f .env.local ]; then
    echo "⚠️  .env.local file does not exist. Creating from .env.local.example..."
    cp .env.local.example .env.local
    echo "✅ .env.local created. Please review and update the configuration if needed."
fi

if [ ! -f docker-compose.yml ]; then
    echo "⚠️  docker-compose.yml file does not exist. Creating from docker-compose.yml.example..."
    cp docker-compose.local.yml docker-compose.yml
    echo "✅ docker-compose.yml created. Please review and update the configuration if needed."
fi

# Start containers
docker compose -f docker-compose.yml --env-file .env up -d --build

echo "✅ Local environment started!"
echo "📊 Services:"
echo "   - MySQL: localhost:3306"
echo "   - Redis: localhost:6379"
echo "   - MinIO API: http://localhost:9001"
echo "   - MinIO Console: http://localhost:9090"
echo "   - RabbitMQ: http://localhost:15672"
echo "   - Proxy: http://localhost"
