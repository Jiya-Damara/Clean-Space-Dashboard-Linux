<div align="center">

# 🧹 Clean Space Dashboard  
### A Terminal-Based File Organizer & Disk Monitoring System

<img src="https://64.media.tumblr.com/4e3ed52f25cff0e7b04babdd19f8e144/tumblr_mkiux8S7Xe1rn57sio1_400.gif" alt="Clean Space Dashboard Animation" />

<h3>Linux System Programming Project</h3>
<p>A sleek and interactive tool to keep your terminal clutter-free and system monitored — right from the command line.</p>

</div>

---

## 👥 Team Members

<div align="center">

<table>
<tr>
<td align="center">
  <b>Anmol</b><br>
  <sub>User Info & UI Design</sub>
</td>
<td align="center">
  <b>Jiya</b><br>
  <sub>File Organizer & Disk Dashboard</sub>
</td>
</tr>
<tr>
<td align="center">
  <b>Anshu Dhawan</b><br>
  <sub>System Monitoring & Alerts</sub>
</td>
<td align="center">
  <b>Damandeep Singh</b><br>
  <sub>System Monitoring & Documentation</sub>
</td>
</tr>
</table>

</div>

---

## 📋 Project Overview

**Clean Space Dashboard** is a terminal-based Bash application that helps Linux users declutter their directories by organizing files by type, tracking disk usage in real-time, and monitoring system users — all through a user-friendly `dialog` interface.

---

## ✨ Key Features

<table>
<tr>
<td width="50%">

### 📁 File Organizer
- Auto-organizes files into categories like Images, Documents, Videos, etc.
- Prevents overwriting files with smart prompts
- Logs actions to `organizer.log`
- Displays file size summary

### 👥 User Info
- Displays currently logged-in users using `who`

</td>
<td width="50%">

### 📊 Disk Usage Dashboard
- Visual system storage via `df -h`
- Disk alert system (e.g. 80% usage)
- Additional tools: `ncdu`, `iostat`, `vmstat`, `top`

### 🚨 Background Alerts
- Monitors `/` disk usage every 5 minutes
- Sends alerts using `wall` or `notify-send`

</td>
</tr>
</table>

---

## 🗂️ Project Structure

```bash
organizer.sh     # Main Bash script
organizer.log    # Log file for file movements
README.md        # Project documentation
```

---

## 🛠️ How It Works

### 🧠 File Organizer Logic
- Scans current directory
- Moves files to `/Images`, `/Videos`, `/Documents`, etc.
- Prompts before overwriting
- Logs count and total size

### 📈 Disk Monitoring Logic
- Disk usage stats via CLI tools
- Alerts user if usage crosses threshold
- Optional background check script

---

## 🖼️ Screenshots

*Add screenshots here:*  
- `main_menu.png`  
- `disk_dashboard.png`  
- `organizer_log.png`

---

## ⚙️ Setup & Usage

### 📦 Requirements

- Linux OS
- `bash`
- `dialog`
- Optional: `ncdu`, `iostat`, `vmstat`, `notify-send`

### 🧪 Install Dependencies

```bash
sudo apt update
sudo apt install dialog ncdu sysstat
```

### ▶️ Run the Script

```bash
chmod +x organizer.sh
./organizer.sh
```

---

## 🎓 Learning Outcomes

- Bash scripting for real-world use
- Linux system programming and utilities
- Disk management & automation
- Using `dialog` for better CLI UX
- Collaboration using Git and terminal tools

---

## 🚀 Future Enhancements

- Desktop/email notifications
- Undo or backup feature
- Web-based log viewer
- Custom user settings

---

## 🙏 Acknowledgments

Special thanks to our **Linux System Programming** instructor for guiding us toward creating meaningful terminal-based utilities.

---

<div align="center">

Built with ❤️ in Bash  
© 2025 Team Clean Space Dashboard

</div>
