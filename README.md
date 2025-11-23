# Zabbix Monitoring Quick Guide
# Zabbix Monitoring System

## 📌 Overview

Zabbix is an enterprise-grade open-source monitoring platform used to track the performance and availability of devices such as servers, network switches, storage, and applications.

It provides:

* Real-time monitoring
* Alerts and notifications
* Trend analysis and dashboards
* Agent-based and agentless monitoring

---

## 🧠 How Zabbix Works

Zabbix operates using several core components:

| Component                    | Role                                                        |
| ---------------------------- | ----------------------------------------------------------- |
| **Zabbix Server**            | Core engine collecting and processing data                  |
| **Zabbix Frontend (Web UI)** | Web interface for configuration, alerts, graphs, dashboards |
| **Zabbix Agent**             | Installed on monitored devices to collect metrics           |
| **Database (MySQL/MariaDB)** | Stores configuration and collected metrics                  |
| **Network (zabbix-net)**     | Docker network allowing component communication             |

Data flows from the **agent ➜ server ➜ database ➜ UI**.

---

## 🏗 System Architecture (Docker-based)

This setup uses Docker to deploy:

* `mysql-server`
* `zabbix-server`
* `zabbix-web-nginx-mysql`
* `zabbix-agent`

All services run inside containers and communicate over a dedicated Docker network.

---

## 📦 Installation Instructions

### 1️⃣ Create a Working Directory

```bash\mkdir zabbix && cd zabbix
```

### 2️⃣ Create Docker Volumes

```bash\docker volume create zabbix-server_mysql_data
```

### 3️⃣ Create Docker Network

```bash\docker network create zabbix-net
```

### 4️⃣ Create `docker-compose.yml`

Copy the yaml content into a file named `docker-compose.yml`:

---

### 5️⃣ Start the Stack

```bash\docker compose up -d
```

### 6️⃣ Verify Running Services

```bash\docker ps
```

You should see **four containers** running.

---

## 🌐 Accessing Zabbix Web UI

Open a browser and go to:

```
http://localhost:8080
```

### Default Login:

| Field    | Value    |
| -------- | -------- |
| Username | `Admin`  |
| Password | `zabbix` |

---

## 🧪 Testing Connectivity

Check database:

```bash\docker exec -it mysql-server mysql -uroot -pzabbix -e "SHOW DATABASES;"
```

Check server logs:

```bash\docker logs zabbix-server
```

---

## 🎉 Setup Complete

Zabbix is now running and ready to monitor hosts, services, and applications.

You can now:

* Add hosts
* Enable templates
* Create custom triggers & alerts
* Configure email or messaging notifications

---

## 📄 Next Steps

✔ Adding Windows/Linux agents

✔ Setting up notifications (e.g., Slack, Telegram, Email)

✔ Custom dashboards and graphs

---

