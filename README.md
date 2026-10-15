# Wall of Shame 🛡️🔥

> A real-time, hacker-themed SSH brute-force monitor and live web dashboard. Expose your attackers with a pitch-black neon red aesthetic.

[![GitHub repository](https://img.shields.io/badge/GitHub-SleepTheGod%2FWall--of--Shame-blue?style=for-the-badge&logo=github)](https://github.com/SleepTheGod/Wall-of-Shame/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

---

## 👁️ What is Wall of Shame?

**Wall of Shame** is a zero-dependency Bash script designed to parse system journal logs for SSH connection attempts (`sshd`), rank attacking IP addresses by volume, and dynamically deploy a live, self-refreshing hacker-themed HTML dashboard to your web server (`/var/www/html/wallofshame.html`).

---

## ✨ Features

- **Zero External Dependencies:** Uses native Linux tools (`journalctl`, `grep`, `sort`, `sed`, `awk`).
- **Cyberpunk Aesthetics:** Pitch-black background (`#000000`), glowing neon white headers, and pulsing red telemetry text (`#ff2a2a`).
- **Live Auto-Updates:** The script loops continuously in the background, and the web page features an automatic refresh loop every 3 seconds.
- **Safe HTML Escaping:** Sanitizes raw data streams to prevent malformed page rendering.

---

## 🚀 Quick Start & Installation

### 1. Clone the Repository
```bash
git clone https://github.com/SleepTheGod/Wall-of-Shame.git
cd Wall-of-Shame
```

### 2. Rename or Use the Script
Make sure the main script is named `main.sh` (or rename the provided script):
```bash
mv wall_of_shame.sh main.sh
```

### 3. Make it Executable
```bash
chmod +x main.sh
```

### 4. Run in the Background (Production Mode)
Because the script runs an infinite telemetry loop to keep your web page updated, run it with `root` privileges via `nohup`:
```bash
sudo nohup ./main.sh > /dev/null 2>&1 &
```

---

## 🌐 Viewing the Dashboard

Once running, navigate to your server's web root:
```text
http://<your-server-ip>/wallofshame.html
```

---

## 🛑 Stopping the Monitor

To stop the background telemetry loop, find its process ID and kill it:
```bash
ps aux | grep main.sh
sudo kill -9 <PID>
```

---

## 📝 License

Distributed under the MIT License. See `LICENSE` for more information.
