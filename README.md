# Inception Project

## Overview

The Inception project is a Docker-based setup that orchestrates a multi-container environment using Docker Compose. It includes services for Nginx, WordPress, and MariaDB, each configured to work together seamlessly.

## Project Structure

Makefile srcs/ .env docker-compose.yml requirements/ mariadb/ .dockerignore Dockerfile tools/ init.sh nginx/ conf/ default.conf Dockerfile wordpress/ .dockerignore conf/ www.conf Dockerfile tools/ create_wordpress.sh init_dir.sh


### Key Files and Directories

- **Makefile**: Contains commands to manage the Docker environment.
- **srcs/.env**: Environment variables for Docker Compose.
- **srcs/docker-compose.yml**: Docker Compose configuration file.
- **srcs/requirements/**: Contains Dockerfiles and configuration for each service (Nginx, WordPress, MariaDB).

## Services

### Nginx

- **Container Name**: `nginx`
- **Build Context**: `srcs/requirements/nginx`
- **Ports**: `443:443`
- **Depends On**: `wordpress`
- **Volumes**: `wordpress_data:/var/www/html`
- **Networks**: `network`

### WordPress

- **Container Name**: `wordpress`
- **Build Context**: `srcs/requirements/wordpress`
- **Expose**: `9000`
- **Depends On**: `mariadb`
- **Volumes**: `wordpress_data:/var/www/html`
- **Networks**: `network`

### MariaDB

- **Container Name**: `mariadb`
- **Build Context**: `srcs/requirements/mariadb`
- **Expose**: `3306`
- **Volumes**: `mariadb_data:/var/lib/mysql`
- **Networks**: `network`

## Makefile Commands

### `all`

Alias for the `up` command.

### `up`

Launches the Docker Compose environment.

make up

### `down`
Stops the Docker Compose environment.

make down

### `re`
Rebuilds and restarts the Docker Compose environment.

make re

### `clean`
Stops the Docker Compose environment and prunes Docker system.

make clean

### `fclean`
Performs a full clean, including Docker networks and volumes.

make fclean

## Environment Setup
Initialize Directories: The init_dir.sh script in srcs/requirements/wordpress/tools/ initializes necessary directories.

Environment Variables: Ensure that the .env file in srcs/ is properly configured with necessary environment variables.

## Usage
Start the Environment: Run make up to build and start the Docker containers.
Stop the Environment: Run make down to stop the Docker containers.
Clean the Environment: Run make clean to prune Docker system.
Full Clean: Run make fclean to remove all Docker networks and volumes.

## Notes
Ensure Docker and Docker Compose are installed on your system.
The project uses Docker Compose version 3.8.
The fclean command will remove all data in the specified volumes.
