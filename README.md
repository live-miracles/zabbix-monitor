
# Zabbix Monitoring System Documentation

## 1. Overview

Zabbix is an open-source monitoring solution used to track system health, performance, and availability of network devices, servers, applications, and media workflows.

This document explains:
- What Zabbix is and key terminology
- How monitoring is organized in our studio network
- Installation details for our Zabbix Server (already deployed)
- How to add a new machine to the monitoring system
- Basic troubleshooting guidance

------------------------------------------------------------

## 2. Current Deployment Summary

Component | Type | Status | Notes
----------|------|--------|-------
Zabbix Server | Docker Compose deployment | Running | Hosted on Mac mini
Database | MySQL 8.0 | Running | Persistent storage enabled
Zabbix Web Interface | NGINX + PHP-FPM | Running | Accessible via browser
Docker Network | zabbix-net | Created | Internal service routing
Storage | Volume-mapped | Persistent | Located on host machine

------------------------------------------------------------

### Zabbix Server Host Information

Parameter | Value
---------|-------
Host Operating System | macOS (Mac mini Server)
Zabbix Admin Panel Access URL | http://192.168.154.113:8080
Local Private Network Address | 192.168.154.113
Data Storage Location | Persistent Docker Volumes

------------------------------------------------------------

## 3. Key Terminologies

Term | Meaning
-----|--------
Server | The main Zabbix instance storing data, processing checks, running triggers, alerts, and web UI.
Agent | Software installed on monitored machines (Windows, Mac, Linux) to collect metrics and send them to the server.
Host | Any monitored device inside Zabbix such as a server, PC, encoder, bridge, or system.
Template | A reusable monitoring rule set including items, triggers, graphs, and discovery rules.
Item | A single metric being monitored (CPU usage, disk space, uptime, temperature, etc.).
Trigger | A condition that turns raw data into meaningful alerts (example: CPU > 95% for 5 minutes).
Action | Automated behavior when trigger fires (email, Slack message, script execution).

------------------------------------------------------------

## 4. Monitoring Scope

Category | Explanation | Method
--------|----------------|-------
Big PCR Machines | BPCR room PCs 7-11| Agent-based monitoring
Studio Machines | Studio machines in Car room 1-12, Main & Backups | Agent-based monitoring
Small PCR Devices | SPCR room PCs | Agent-based monitoring
AJA Bridges | AJA hardware bridges | HTTP polling automation

------------------------------------------------------------

## 5. Zabbix Server Installation (already completed)

The server is deployed using Docker Compose.

Commands executed:

```
cd server;
docker network create zabbix-net;
docker compose up -d;
```

All containers launch automatically and persist across reboot.

------------------------------------------------------------

## 6. Adding New Windows Machines to Monitoring

Follow the steps below to install and configure the Zabbix agent on new Windows machines and register them in Zabbix.

---

### **Step 1 — Download and Install Zabbix Agent**

1. Download the latest Windows Zabbix Agent (OpenSSL version) from:  
   https://www.zabbix.com/download_agents?version=7.4&release=7.4.3&os=Windows&os_version=Any&hardware=amd64&encryption=OpenSSL&packaging=Archive&show_legacy=0

2. Extract the downloaded ZIP file into:

```
C:\Program Files\Zabbix Agent
```

3. Open PowerShell **as Administrator**, then navigate into the installation path:

```powershell
cd "C:\Program Files\Zabbix Agent\bin"
```

4. Install the agent as a Windows service:

```powershell
.\zabbix_agentd.exe --config "C:\Program Files\Zabbix Agent\conf\zabbix_agentd.conf" --install
```

---

### **Step 2 — Configure the Agent**

Edit the configuration file:

```
C:\Program Files\Zabbix Agent\conf\zabbix_agentd.conf
```

Update the configuration file for zabbix agent, templates in `./windows-agents/zabbix-agentd.conf`.


> Ensure **Hostname matches exactly the host entry** configured in the Zabbix frontend.

After editing, restart the service so changes take effect:

```powershell
Restart-Service "Zabbix Agent"
```

---

### **Step 3 — Allow Firewall**

Open port **10050** for agent communication:

```powershell
New-NetFirewallRule -DisplayName "Zabbix Agent" -Direction Inbound -Protocol TCP -LocalPort 10050 -Action Allow
```

---

### **Step 4 — Verify Connectivity**

Run the following command from the Zabbix server or another monitored machine with zabbix_get installed:

```powershell
zabbix_get -s <IP_ADDRESS> -p 10050 -k "system.uptime"
```

Expected Output:

```
12345
```

If the value returns, the agent is communicating successfully.

---

### **Step 5 — Register Host in Zabbix UI**

1. Go to:  
   **Configuration → Hosts → Create Host**
2. Fill in:
   - **Host name:** _must match Hostname in config_
   - **Visible name:** optional
   - **Group:** select relevant category
   - **Interface:**  
     - Agent  
     - IP address of the machine  
     - Port: `10050`
3. Assign appropriate **Templates** (e.g., Windows by Zabbix Agent).
4. Save.

---

### **Step 6 — Confirm Monitoring**

After 1–3 minutes:

- Host status should turn **green (ZBX ON)**.
- Latest data should start appearing.

If not, check:

```powershell
Get-Service "Zabbix Agent"
Get-Content "C:\Program Files\Zabbix Agent\zabbix_agentd.log" -Tail 50
```

---

✔ **Machine is now active and monitored.**


------------------------------------------------------------

## 7. Troubleshooting

Issue | Fix
------|-----
Host unreachable | Check firewall + agent service status
Data missing | Check Server and ServerActive IP config
Ping OK but no data | Template missing or items disabled
------------------------------------------------------------

## 8. Future Improvements

- Slack/Email alert actions
- Dashboard UI refinements


