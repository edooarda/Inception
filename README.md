*This project has been created as part of the 42 curriculum by edribeir.*

# Inception
 
This project is a Docker-based infrastructure composed of **NGINX**, **WordPress**, and **MariaDB**, built locally from scratch using custom Dockerfiles based on Debian Bookworm Version.

The goal of this project is to understand how containers communicate, how services are orchestrated with Docker Compose, and how persistent data is managed using volumes.

---

## 📦 Architecture

```
Internet
   │
   ▼
NGINX (HTTPS :443)
   │  FastCGI
   ▼
WordPress (PHP-FPM :9000)
   │  MySQL
   ▼
MariaDB (:3306)
```

Each service runs in its **own container**:
- **NGINX**: container acting as the single entrypoint, secured with TLSv1.2/1.3 (HTTPS)
- **WordPress**: PHP application using PHP-FPM
- **MariaDB**: Database backend base on MySQL

---

## 🗂 Project Structure

```
inception/
├── srcs/
│   ├── docker-compose.yml
│   ├── .env
│   └── requirements/
│       ├── mariadb/
│       │   ├── conf/
│       │   │    └── configfile.cnf
│       │   ├── tools/
│       │   │    └── script.sh
│       │   └── Dockerfile
│       ├── wordpress/
│       │   ├── conf/
│       │   │    └── configfile.conf
│       │   ├── tools/
│       │   │    └── script.sh
│       │   └── Dockerfile
│       └── nginx/
│           ├── conf/
│           │    └── configfile.conf
│           └── Dockerfile
├── MAKEFILE
├── README.md
├── USER_DOC.md
└── DEV_DOC.md
```

---

### Requirements
Need to have it installed on the computer:
- Linux virtual machine (not essencial)
- Docker
- Docker Compose
- Make



## 🚀 How to Run

```bash
make
```

Then open:
```
https://localhost
```
or

```
https://localhost:443
```

To stop the project:
```bash
make down
```

---

## 🧠 Key Concepts

- No pre-built images (everything built locally)
- HTTPS only (TLS via OpenSSL)
- Persistent volumes stored in `$HOME/data`
- Services communicate via Docker networks called Inception

---

### Design Choices and Technical Comparisons

**Virtual Machines vs Docker**
- Virtual Machines (VMs) run a complete operating system on top of a hypervisor.
Each VM includes its own kernel, system libraries, and applications, which makes them heavy in terms of disk space and memory usage. VMs take longer to start and require more system resources.
- Docker runs applications inside lightweight containers that share the host operating system’s kernel.
Containers are faster to start, consume fewer resources, and allow multiple services to run efficiently on the same system.

**Secrets vs Environment Variables**
- Environment variables are used in this project to store configuration values such as database credentials. They are defined in a `.env` file and injected into containers at runtime by Docker Compose.

- Docker secrets are a more secure mechanism designed mainly for Docker Swarm and production environments. Secrets are stored encrypted by Docker and are not visible through environment inspection commands or container logs.

In this project, environment variables were chosen instead of Docker secrets because:
- The subject does not require Docker Swarm.
- The project runs in a local development environment.
- Using `.env` files keeps the configuration simple and readable for evaluation.


**Docker Network vs Host Network**
- Docker networks provide isolation and controlled communication between containers.
- At this project it was used the Inception Network, it can be found in the docker compose.
- Host networking removes isolation exposes services to the host network and reduces security and flexibility.

**Docker Volumes vs Bind Mounts**
- Volumes are managed by Docker and recommended for persistent application data, as Database or the Wordpress setup from this project.
- Bind mounts link a specific directory from the host machine to a directory inside the container.
- In this project, the volumes are named volumes with bind mounts, is means that the actual data is stored in a specific host directory.


All containers are running using Debian 12 called Bookworm, this is the current oldstable release as required in the subject in December/25.
---

## Resources

- https://docs.docker.com/reference/compose-file/volumes/
- https://www.youtube.com/watch?v=pg19Z8LL06w
- https://mariadb.com/docs/server/mariadb-quickstart-guides/mariadb-connecting-guide
- https://developer.wordpress.org/cli/commands/

### 🤖 AI Usage

AI tools were used to:
- Assist with drafting configuration explanations
- Improve documentation clarity and structure
