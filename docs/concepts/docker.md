# Docker & Docker Compose Essentials

This documentation provides a breakdown of the most common commands used to manage containers and multi-container applications.

---

## 1. Basic Docker Commands
These commands are used to manage individual containers and images.

| Command | Description |
| :--- | :--- |
| `docker run <image>` | Creates and starts a container from an image. |
| `docker ps` | Lists all running containers (use `-a` to see stopped ones). |
| `docker images` | Lists all locally stored images. |
| `docker stop <id/name>` | Gracefully stops a running container. |
| `docker rm <id/name>` | Deletes a stopped container. |
| `docker rmi <image>` | Deletes a local image. |
| `docker exec -it <name> bash` | Opens an interactive terminal inside a running container. |

---

## 2. Docker Compose
Docker Compose allows you to define and run multi-container applications using a `docker-compose.yml` file.

### The Core Commands
* **`docker-compose up`**
    Starts the entire stack defined in your YAML file. 
    * Use `-d` (detached mode) to run it in the background.
    * Use `--build` to force a rebuild of images before starting.
* **`docker-compose down`**
    Stops and **removes** containers, networks, and images defined in the file.
* **`docker-compose stop`**
    Stops the containers but does **not** remove them.
* **`docker-compose logs -f`**
    Follows the real-time log output from all services in the stack.
* **`docker-compose ps`**
    Lists the status of the containers specifically managed by the current compose file.

---

## 3. Advanced Variations & Nuances

### Execution Context
Depending on your installation, you might use:
* `docker-compose` (The classic standalone python script).
* `docker compose` (The modern V2 version integrated directly into the Docker CLI).

> **Note:** For most modern setups, `docker compose` (without the hyphen) is the preferred standard.

### Scaling Services
If you need multiple instances of a specific service (like a worker node):
```bash
docker compose up -d --scale worker=3
```
### Checking Configurations
If you have complex environment variables or multiple override files, use:

```bash
docker compose config
```
## 4. Cleaning Up
Docker can eat up disk space quickly. Use these to reclaim it:

* `docker system prune`: Removes all unused containers, networks, and dangling images.
* `docker volume prune`: Removes all volumes not used by at least one container.
* `docker image prune -a`: Removes all images which are not used by existing containers.