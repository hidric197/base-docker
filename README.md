# docker-base

Multi-stage Docker base image + compose examples for Laravel (Vite enabled), Redis, MySQL, Horizon.

## 📁 Docker Compose File Structure

The project uses a multi-file structure to separate environments:

- **docker-compose.local.yml** - Configuration for local development (exposes ports, no SSL)
- **docker-compose.production.yml** - Configuration for production (security, SSL, restart policies)
- **docker-compose.yml** - (Optional) Copy from local/production files to run directly

## 🚀 Quickstart (Local Development)

### Method 1: Use the script (Recommended)

```bash
# Make the script executable (only needed once)
chmod +x start-local.sh

# Start
./start-local.sh
```

### Method 2: Manual

1. Copy environment file:
```bash
cp .env.local.example .env
```

2. Start services:
```bash
docker compose -f docker-compose.local.yml --env-file .env up -d --build
```

3. Services will be available on ports:
  - MySQL: `localhost:3306`
  - Redis: `localhost:6379`
  - MinIO API: `http://localhost:9001`
  - MinIO Console: `http://localhost:9090`
  - RabbitMQ: `http://localhost:15672`
  - Nginx Proxy: `http://localhost`

### Using with a Laravel project

In your project, create a `docker-compose.override.yml` file:

```yaml
version: "3.9"

services:
  laravel_app:
   build: .
   volumes:
    - .:/var/www/html/project-name
   labels:
    - "VIRTUAL_HOST=myapp.localhost"
    - "VIRTUAL_PORT=80"
   networks:
    - app_network

networks:
  app_network:
   external: true
```

## 🌐 Quickstart (Production)

### Manual

1. Create and configure the environment file:
```bash
cp .env.production.example .env
# Update all security values in .env.production
```

2. Start services:
<!-- This file should be created separately and ignored in the project when deploying -->

```bash
docker compose -f docker-compose.production.yml --env-file .env up -d --build
```

### Using with a Laravel project in Production

```yaml
version: "3.9"

services:
  laravel_app:
   build:
    context: .
    dockerfile: Dockerfile.production
   restart: unless-stopped
   labels:
    - "VIRTUAL_HOST=yourdomain.com"
    - "VIRTUAL_PORT=80"
    - "LETSENCRYPT_HOST=yourdomain.com"
    - "LETSENCRYPT_EMAIL=admin@yourdomain.com"
   networks:
    - app_network

networks:
  app_network:
   external: true
```

## 🔧 Useful Commands

```bash
# View logs
docker compose -f docker-compose.local.yml -f docker-compose.yml logs -f

# Stop services
docker compose -f docker-compose.yml -f docker-compose.local.yml down

# Stop and remove volumes
docker compose -f docker-compose.yml -f docker-compose.local.yml down -v

# Rebuild a specific service
docker compose -f docker-compose.yml -f docker-compose.local.yml build mysql
```

## Automatic HTTPS with Let's Encrypt

The project includes built-in Let's Encrypt support to automatically issue and renew SSL certificates.

### Configuration

1. Copy `.env.example` to `.env` and configure the email:
```bash
cp .env.example .env
```

2. Edit `LETSENCRYPT_EMAIL` in the `.env` file with your real email:
```env
LETSENCRYPT_EMAIL=your-email@example.com
```

### Using HTTPS for a service

In the project's `docker-compose.override.yml` file, add the following labels:

```yaml
services:
  your-service:
   labels:
    - "VIRTUAL_HOST=yourdomain.com"
    - "VIRTUAL_PORT=80"
    - "LETSENCRYPT_HOST=yourdomain.com"
    - "LETSENCRYPT_EMAIL=your-email@example.com"
```

Notes:
- HTTPS only works with a real domain (not `.localhost` or `127.0.0.1`)
- The domain must point to your server's IP
- Ports 80 and 443 must be open on the firewall
- Certificates will be automatically renewed before expiration

### Check certificates

```bash
docker exec nginx-proxy ls -la /etc/nginx/certs
```

### Logs

```bash
# View Let's Encrypt companion logs
docker logs nginx-proxy-letsencrypt

# View nginx proxy logs
docker logs nginx-proxy
```
