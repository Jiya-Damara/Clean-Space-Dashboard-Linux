# 🛠️ Clean Space Dashboard - Terminal-Based File Organizer & Disk Dashboard

An interactive terminal-based system for organizing files and monitoring system resources using Bash and `dialog`.

---

## 👥 Team Members

- **Anmol** – User Info & UI Design 
- **Jiya** –  File Organizer & Disk Dashboard
- **Anshu Dhawan** – System Monitoring & Alerts  
- **Damandeep Singh** – Code Review & Documentation

---

## 📋 Project Overview

**Clean Space Dashboard** is a powerful yet lightweight Linux terminal utility that helps users **organize files**, **monitor system storage**, and **view logged-in users**, all from an interactive menu using the `dialog` command. It is designed for CLI enthusiasts and beginners alike.

---

## ✨ Key Features

### 📁 File Organizer  
- Organizes files by type (Images, Videos, Documents, Music, etc.)
- Prompts for confirmation before overwriting
- Human-readable file size display
- Logs every action into `organizer.log`

### 📊 Disk Usage Dashboard  
- Real-time disk usage (`df -h`)
- Alerts if disk usage exceeds a set threshold (e.g., 80%)
- Tools like `ncdu`, `iostat`, `vmstat`, `top`
- Background alerting via `wall` and `notify-send`

### 👥 User Info  
- Shows currently logged-in users using `who`

### 🚨 Background Alerts  
- Monitors disk usage of root (`/`) partition every 5 minutes
- Sends terminal warnings when usage exceeds threshold

---

## 📂 Project Structure

```bash
organizer.sh     # Main Bash script
organizer.log  # Log file for file movements
README.md      # Documentation
```

---

## ⚙️ How It Works

### File Organizer

- Scans current directory for files of specific types
- Moves files into respective folders (`/Images`, `/Videos`, etc.)
- Prevents overwriting with prompts
- Records count and size in logs

### Disk Dashboard

- Menu-based viewer for storage stats
- Auto-alerts when disk usage exceeds limits
- Offers visual and statistical system health reports

---

## 📸 Screenshots

*Add terminal screenshots here if available (e.g., `main_menu.png`)*

---

## 🛠️ Setup & Usage

### Requirements

- Linux OS
- `bash`
- `dialog`
- Optional: `ncdu`, `iostat`, `vmstat`, `notify-send`

### Install dependencies

```bash
sudo apt update
sudo apt install dialog ncdu sysstat
```

### Run the script

```bash
chmod +x systidy.sh
./systidy.sh
```

---

## 📚 Learning Outcomes

- Bash scripting & Linux terminal automation
- Disk and file system monitoring
- Using `dialog` for text-based UIs
- Background process scripting
- Working collaboratively on a CLI project

---

## 🔮 Future Enhancements

- Desktop notifications or email alerts
- Web-based log viewer dashboard
- Custom folder configuration
- Backup and undo options

---

## 🤝 Acknowledgments

Special thanks to our Linux System Programming faculty for motivating us to build and deliver real-world shell-based tools.

---

<p align="center">Built with ❤️ in Bash | © 2025 Team Clean Space Dashboard</p>

