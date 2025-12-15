# 📜 Developer Documentation

This document explains the **technical design choices** and internal workings of the Inception project.

---

## 🚨 Prerequisites

- Linux VM
- Docker & Docker Compose installed
- Make installed
- Valid domain mapped to local IP (`<login>.42.fr`)

## ⚠️ Environment Setup

1. Clone the repository
2. Create `.env` file in `srcs/`
You will need this variables:
```
    DOMAIN_NAME=

    MYSQL_USER=
    MYSQL_PASSWORD=
    MYSQL_DATABASE=

    MYSQL_ROOT_PASSWORD=

    WP_ADMIN=
    WP_ADMIN_EMAIL=
    WP_ADMIN_PASSWORD=

    WP_USER=
    WP_USER_EMAIL=
    WP_USER_PASSWORD=

```
3. Ensure domain resolves to VM IP
   To check:
   ```bash
    sudo nano etc/hosts
   ```

## Build and Launch

```bash
make
```
## To clean and delete everything EVEN VOLUMES
```bash
make fclean
```

This runs Docker Compose with custom-built images.

##  Container Management Commands

- Stop containers: `docker compose down` or `make down`
- Rebuild images: `make re`
- Restart services: `docker compose restart`
- Inspect network: `docker network inspect inception`

---

## 🧱 Containers Overview

### MariaDB
- Base image: `debian:bookworm`
- Runs `mysqld_safe`
- Database initialized via custom script
- Data persisted via bind-mounted volume

---

### WordPress
- Base image: `debian:bookworm`
- PHP-FPM (port 9000)
- WordPress installed at runtime using WP-CLI
- Communicates with MariaDB via Docker network

Important:
- WordPress setup runs only if `wp-config.php` does not exist, better usage of resources this way.

---

### NGINX
- Base image: `debian:bookworm`
- TLS enabled with OpenSSL
- Listens on port 443 only

---

## 🔗 Networking

- Custom bridge network: `inception`
- Containers communicate via service names

Examples:
- `mariadb:3306`
- `wordpress:9000`

---

## 💾 Volumes

Volumes are bind-mounted to host directories:

```
$(HOME)/data/mariadb
$(HOME)/data/wordpress
```

---

## 🔐 Security

- HTTPS only
- Self-signed certificates
- No credentials hardcoded in images
- Environment variables passed via `.env`

---

## 🛠 Debugging Tips

```bash
docker compose ps
docker compose logs
```

Inside containers:

```bash
docker exec -it wordpress bash
docker exec -it mariadb bash
```

---

## 📌 Design Principles

- One service per container
- No unnecessary background processes
- Idempotent startup scripts
- Clear separation between build-time and runtime
