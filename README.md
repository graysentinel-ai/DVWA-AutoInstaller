<!-- GRAYSENTINEL CYBER DEFENCE LAB – DVWA AUTO-INSTALLER README -->
<!-- ⚡ CLASSIFIED OPERATIONAL DEPLOYMENT TOOL ⚡ -->

<div align="center" style="background:#0B0B0B; border:2px solid #39FF14; border-radius:6px; padding:18px 0; margin-bottom:18px; box-shadow:0 0 20px rgba(57,255,20,0.15);">
  <p style="margin:0;">
    <img src="https://img.shields.io/badge/GRAYSENTINEL-COMMAND–AUTHORITY-0B0B0B?style=for-the-badge&labelColor=39FF14&color=0B0B0B" alt="GraySentinel"/>
    <img src="https://img.shields.io/badge/CLEARANCE–TOP_SECRET-FF4500?style=for-the-badge&color=0B0B0B" />
  </p>
  <p style="margin:8px 0 0 0;">
    <img src="https://img.shields.io/badge/DVWA-AUTO_INSTALLER-39FF14?style=flat-square&color=0B0B0B" />
    <img src="https://img.shields.io/badge/KALI-LINUX-1793D1?style=flat-square&logo=kali-linux&logoColor=white&color=0B0B0B" />
    <img src="https://img.shields.io/badge/BASH-SCRIPT-4EAA25?style=flat-square&logo=gnu-bash&logoColor=white&color=0B0B0B" />
    <img src="https://img.shields.io/badge/VERSION-1.0.0-39FF14?style=flat-square&color=0B0B0B" />
  </p>
  <h1 style="color:#39FF14; font-family:'Courier New',monospace; text-shadow:0 0 8px #39FF14; letter-spacing:3px; margin:14px 0 4px 0;">⚡ DVWA : : AUTO‑DEPLOY ⚡</h1>
  <p style="color:#AAAAAA; font-family:'Courier New',monospace; font-size:16px; margin:0;">ZERO‑TOUCH LAB PROVISIONING – TIME TO VULNERABLE <span style="color:#FF4500;">&lt; 180s</span></p>
  <hr style="border:0.5px solid #39FF14; width:60%; margin:14px auto;"/>
  <p style="color:#CCCCCC; font-family:'Courier New',monospace; margin:0;">
    <strong>OP:</strong> DEPLOY_TARGET &nbsp;&nbsp;|&nbsp;&nbsp; <strong>CMDR:</strong> RITIK SHRIVAS &nbsp;&nbsp;|&nbsp;&nbsp; <strong>UNIT:</strong> GSCDL
  </p>
  <p style="color:#888888; font-family:'Courier New',monospace; font-size:14px; margin:4px 0 0 0;">45‑DAY CYBER COMMISSIONING PROGRAMME – PHASE 1 : BUILD THE BATTLEFIELD</p>
</div>

---

### 🎯 **OPERATIONAL CONTEXT**

A financial institution spent 72 hours constructing a vulnerable test environment. By the time the lab was operational, the penetration testing window had expired. An unpatched SQL injection in their production login portal was left undiscovered for <span style="color:#FF4500;">187 days</span>.

**You are not that institution.**

This tool executes **Operation Deploy Target** – a fully automated, single‑command installation of Damn Vulnerable Web Application (DVWA) on Kali Linux. No manual configuration. No dependency hunting. No wasted training cycles. The only barrier between you and a live‑fire vulnerability lab is `sudo ./dvwainstaller.sh`. Every second saved on deployment is a second spent on **exploitation**.

---

## 🚀 **MISSION EXECUTION (CUT‑PASTE READY)**

```bash
git clone https://github.com/graysentinel-ai/DVWA-AutoInstaller.git
cd DVWA-AutoInstaller
chmod +x dvwainstaller.sh
sudo ./dvwainstaller.sh
```

Upon successful completion, direct your browser to:

🔗 **`http://127.0.0.1/DVWA/login.php`**

| **ASSET**       | **CREDENTIAL** |
|-----------------|----------------|
| Username        | `admin`        |
| Password        | `password`     |
| Security Level  | `low` *(escalate via DVWA Security panel)* |

---

## ⚙️ **DEPLOYMENT PHASES – 9‑STEP BATTLE RHYTHM**

| PHASE | OBJECTIVE                                          | AUTO‑CONFIGURED |
|:-----:|----------------------------------------------------|:---------------:|
|   1   | **Refresh repository index** – sync Kali mirrors  | ✅ |
|   2   | **Install Apache2, MariaDB, PHP** + required modules (php‑gd, php‑xml, php‑mbstring) | ✅ *(zero prompts)* |
|   3   | **Activate & enable services** – Apache & MariaDB brought online | ✅ |
|   4   | **Provision database** – create `dvwa` user and schema | ✅ |
|   5   | **Clone DVWA** from official upstream repository   | ✅ |
|   6   | **Auto‑configure `config.inc.php`** – database credentials injected | ✅ |
|   7   | **Enable `allow_url_include` & `allow_url_fopen`** in `php.ini` | ✅ |
|   8   | **Restart Apache** – apply all runtime changes      | ✅ |
|   9   | **Trigger DVWA setup** – populate database tables   | ✅ |

> [!TIP]
> All phases are idempotent. Re‑running the script safely removes and re‑clones DVWA while preserving your database. **Zero typos. Zero misconfiguration. 100% reliability.**

---

## 🖥️ **BATTLEFIELD TELEMETRY – LIVE TERMINAL OUTPUT**

```console
╔══════════════════════════════════════════════════════╗
║       GRAYSENTINEL CYBER DEFENCE LAB                 ║
║       DVWA Automated Deployment System               ║
║       Developer: Ritik Shrivas                       ║
╚══════════════════════════════════════════════════════╝

[STEP] Updating package lists...
⠙ Refreshing repositories...
[  ✔  ] Package lists updated.

[STEP] Installing required packages...
[###########                                         ] 3/8 Installing php-gd
...
[  ✔  ] All packages installed.

[STEP] Starting Apache & MariaDB...
⠹ Booting services...
[  ✔  ] Services up and enabled.

[STEP] Creating DVWA database and user...
[  ✔  ] Database configured.

[STEP] Downloading DVWA source code...
⠼ Cloning repository...
[  ✔  ] DVWA downloaded.

[STEP] Setting up DVWA configuration...
[  ✔  ] DVWA configured (default security: low).

[STEP] Enabling PHP allow_url_include...
[  ✔  ] PHP configuration updated.

[STEP] Restarting Apache...
⠴ Rebooting web server...
[  ✔  ] Apache restarted.

[STEP] Finalising DVWA database setup...
[  ✔  ] DVWA database tables created.

╔══════════════════════════════════════════════════════╗
║          🎉  DVWA INSTALLATION COMPLETE  🎉         ║
╚══════════════════════════════════════════════════════╝

  ➤  URL:      http://127.0.0.1/DVWA/login.php
  ➤  Username: admin
  ➤  Password: password
  ➤  Security level set to LOW
```

---

## 💚 **WHY GRAYSENTINEL OPERATORS USE THIS**

| **MANUAL METHODOLOGY**                          | **GRAYSENTINEL AUTOMATED WAY**                 |
|-------------------------------------------------|------------------------------------------------|
| 20‑40 minutes of terminal entanglement          | **< 180 seconds** – completely hands‑off      |
| Manually editing `config.inc.php`               | **Zero file editing**                         |
| Broken `php.ini` – file inclusion labs disabled | **Auto‑patched correctly**                    |
| “It doesn’t work” frustration                   | **Reliable, repeatable, predictable**         |
| Training time wasted on setup                   | **100% of time spent on exploitation**        |

*In the 45‑Day Cyber Commissioning Programme, every minute matters. This tool ensures your first minute is spent on target, not on configuration.*

---

## 🧪 **FIELD TEST – FRESH KALI VM**

1. **Launch** a clean Kali Linux virtual machine.
2. **Paste** the three Quick‑Start commands into a terminal.
3. **Observe** the script paint the screen with spinners and progress bars.
4. **Navigate** to `http://127.0.0.1/DVWA` and commence exploitation.

> [!IMPORTANT]
> DVWA is **intentionally vulnerable**. **Never expose it to public networks or use it against systems you do not own.** This is a training instrument – maintain operational security as you would in a live‑fire exercise.

---

## 🛡️ **THE GRAYSENTINEL OATH**

<div align="center" style="background:#0B0B0B; border-left:4px solid #39FF14; padding:14px; margin:18px 0;">
  <p style="color:#39FF14; font-family:'Courier New',monospace; font-size:18px; margin:0;">“I will defend, detect, and disrupt. I am the sentinel.”</p>
  <p style="color:#AAAAAA; font-family:'Courier New',monospace; margin:6px 0 0 0;">– The GraySentinel Oath</p>
</div>

This tool is a component of the **GraySentinel 45‑Day Cyber Commissioning Programme** – the only training that produces **proof, not certificates**. From day one, you operate in a mission‑driven environment. By day 45, you hold a portfolio of real scripts, a public GitHub presence, and the rank of Commissioned Officer.

---

## 🔗 **JOIN THE GRAYSENTINEL COMMAND**

| Channel | Link |
|---------|------|
| 📱 **WhatsApp Community** (cheatsheets, alerts, micro‑tasks) | [Join](https://whatsapp.com/channel/0029VbBOVxO5q08VA1YLyS1P) |
| ⚔️ **45‑Day Commissioning Programme** (₹4,999, limited seats) | [Enroll](https://form.svhrt.com/69ce8645001e39939d471236) |
| 📧 **Direct Contact** | [GraySentinel.ai@gmail.com](mailto:GraySentinel.ai@gmail.com) |
| 🐙 **GitHub Organisation** | [graysentinel-ai](https://github.com/graysentinel-ai) |

---

<!-- ⚡ FOOTER – FULL WIDTH COMMAND AUTHORISATION ⚡ -->
<div align="center" style="background:#0B0B0B; border:2px solid #39FF14; border-radius:6px; padding:18px 0; margin-top:24px; box-shadow:0 0 20px rgba(57,255,20,0.15);">
  <p style="color:#39FF14; font-family:'Courier New',monospace; font-size:22px; text-shadow:0 0 8px #39FF14; letter-spacing:2px; margin:0;">⚡ ONCE A GRAYSENTINEL, ALWAYS A GRAYSENTINEL ⚡</p>
  <p style="color:#FF4500; font-family:'Courier New',monospace; font-size:18px; margin:8px 0 0 0;">– Ritik Shrivas 🛡️</p>
  <p style="color:#AAAAAA; font-family:'Courier New',monospace; font-size:16px; margin:4px 0 0 0;">Founder & Chief Mentor, GraySentinel Cyber Defence Lab</p>
  <hr style="border:0.5px solid #39FF14; width:50%; margin:14px auto;"/>
  <p style="color:#888888; font-family:'Courier New',monospace; font-size:13px; margin:0;">
    📱 <a href="https://whatsapp.com/channel/0029VbBOVxO5q08VA1YLyS1P" style="color:#39FF14;">WhatsApp</a> |
    ⚔️ <a href="https://form.svhrt.com/69ce8645001e39939d471236" style="color:#FF4500;">Programme</a> |
    📧 <a href="mailto:GraySentinel.ai@gmail.com" style="color:#39FF14;">Email</a> |
    🐙 <a href="https://github.com/graysentinel-ai" style="color:#FFFFFF;">GitHub</a>
  </p>
</div>
