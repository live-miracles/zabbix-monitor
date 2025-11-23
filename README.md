
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
Zabbix Access URL | http://192.168.154.113:8080 or http://localhost:8080
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

Category | Example Devices | Method
--------|----------------|-------
BPCR Machines | Broadcast control room PCs | Agent-based monitoring
AJA Bridges | AJA hardware bridges | HTTP polling automation
Studio Machines | Studio recording and streaming systems | Agent-based monitoring
Small PCR Devices | Auxiliary systems | Agent or SNMP monitoring

------------------------------------------------------------

## 5. Zabbix Server Installation (already completed)

The server is deployed using Docker Compose.

Commands executed:

docker network create zabbix-net
docker compose up -d

All containers launch automatically and persist across reboot.

------------------------------------------------------------

## 6. Adding New Machines to Monitoring

### Step 1 — Install Zabbix Agent

TBD

### Step 2 — Configure Agent

TBD

### Step 3 — Allow Firewall

TBD

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


