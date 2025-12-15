# 📜 User Documentation

This document explains how to **use and verify** the Inception project as an end user.

---

## 🔐 Accessing the Website

`⛔ YOU WILL NEED THE *.env* file to run the project!`

After starting the containers, open your browser and go to:

```
https://localhost
```
or

```
https://localhost:443
```

⚠️ A security warning may appear because a self-signed certificate is used. This is expected.

---

## 👤 WordPress Access

### Admin Panel

```
https://localhost/wp-admin
```

Login credentials are defined in the `.env` file:
- Admin username
- Admin password


---

OR it can be used with the login, if it was properly mapped as explained in the DEV_DOC.md

- Website: https://<login>.42.fr
- WordPress Admin Panel: https://<login>.42.fr/wp-admin

---

## 🔁 Persistence Test

1. Stop containers:
   ```bash
   make down
   ```
2. Start again:
   ```bash
   make
   ```
3. Confirm:
   - Posts still exist
   - Users still exist

---

## 📂 Data Location

Persistent data is stored on the host machine:

```
$(HOME)/data/mariadb
$(HOME)/data/wordpress
```

Do NOT delete these folders unless you want to reset the project.

---

## ❓ Troubleshooting

- If the site does not load: check NGINX container
- If WordPress shows DB error: check MariaDB container
- Use logs:

```bash
docker compose logs wordpress
docker compose logs mariadb
```

