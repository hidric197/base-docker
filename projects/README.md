# Docker Compose Override Configuration

## Overview

The `docker-compose.override.yml` file allows you to customize your Docker Compose configuration for local development without modifying the main `docker-compose.yml` file.

## Setup

### 1. Create the Override File

Create a `docker-compose.override.yml` file in the same directory as your `docker-compose.override.example.yml`:

```bash
cp docker-compose.override.example.yml docker-compose.override.yml
```

### 2. Basic Structure

```yaml
version: '3.8'

services:
    your-service-name:
        # Your overrides here
```

### 3. Common Override Examples

**Mount local volumes for development:**
```yaml
services:
    app:
        volumes:
            - ./src:/app/src
            - ./config:/app/config
```

**Expose additional ports:**
```yaml
services:
    app:
        ports:
            - "8080:8080"
            - "9229:9229"  # Debug port
```

**Set environment variables:**
```yaml
services:
    app:
        environment:
            - DEBUG=true
            - LOG_LEVEL=debug
```

**Override command:**
```yaml
services:
    app:
        command: npm run dev
```

## Usage

Docker Compose automatically applies the override file when you run:

```bash
docker-compose up
```

To explicitly specify files:

```bash
docker-compose -f docker-compose.yml -f docker-compose.override.yml up
```

## Best Practices

- Add `docker-compose.override.yml` to `.gitignore` if it contains local settings
- Use `docker-compose.override.yml.example` as a template for team members
- Keep production configurations separate from override files
