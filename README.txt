# 🧅 S7 Swarm - Insta Tor Multi-Session Automation

====================================================
                🚀 PROJECT OVERVIEW
====================================================

S7 Swarm is a Linux automation framework designed to
launch multiple isolated Chromium browser sessions
using Tor network routing.

It focuses on:
- Multi-session browser automation
- Tor proxy routing per session
- Window grid layout management
- Lightweight Bash-based execution

====================================================
                ⚙️ FEATURES
====================================================

✔ Multi Chromium sessions  
✔ Tor SOCKS proxy routing  
✔ Automatic window positioning  
✔ Per-session browser profiles  
✔ Screen-aware grid layout  
✔ Safe shutdown (Ctrl + C)  
✔ Lightweight and fast execution  

====================================================
                📦 REQUIREMENTS
====================================================

Required packages:

- tor
- chromium
- xdotool
- wmctrl
- x11-utils
- fontconfig
- curl

====================================================
                📁 FILES STRUCTURE
====================================================

insta_open_iptor/
│
├── insta_tor3.sh      # Main automation script
├── setup_s7.sh        # Setup & installer script
├── README.md          # Documentation file

====================================================
                🧠 HOW IT WORKS
====================================================

1. Installs required dependencies
2. Configures Tor service
3. Launches multiple Chromium instances
4. Assigns proxy routing per session
5. Arranges windows in grid layout
6. Keeps sessions active until stopped

====================================================
                ⚠️ IMPORTANT NOTES
====================================================

- Recommended sessions: 1 - 12
- Too many sessions may slow system performance
- Tor must be running before execution
- Each session uses isolated browser profile

====================================================
                🛑 STOP TOOL
====================================================

Press:

CTRL + C

This will close all active sessions safely.

====================================================
        ▶️ HOW TO RUN (ENGLISH INSTRUCTIONS)
====================================================

1. Give execute permission to setup file:
----------------------------------------------------
chmod +x setup_s7.sh

2. Run setup installer:
----------------------------------------------------
./setup_s7.sh

3. Make main script executable:
----------------------------------------------------
chmod +x Swarm.sh

4. Run the tool:
----------------------------------------------------
./Swarm.sh

5. Follow on-screen instructions:
----------------------------------------------------
- Enter number of sessions (1–12)
- Enter target URL or press Enter for default
- Wait for automatic session launch

====================================================
                🧅 DISCLAIMER
====================================================

This tool is intended for educational and testing
purposes only. Users are responsible for their usage.

====================================================
                👨‍💻 AUTHOR
====================================================

S7 Swarm Framework
Linux Automation & Research Tool
====================================================
