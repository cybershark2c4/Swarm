#!/bin/bash

clear
echo -e "\e[1;31m"
echo "======================================"
echo "      S7 SWARM SETUP (FIXED)"
echo "======================================"
echo -e "\e[0m"

echo "[*] Updating system..."
sudo apt update -y

echo "[*] Installing required tools..."
sudo apt install -y tor chromium xdotool wmctrl x11-utils fontconfig fonts-dejavu-core curl

echo "[*] Fixing Tor service (IMPORTANT)..."


sudo systemctl disable tor@default 2>/dev/null
sudo systemctl stop tor@default 2>/dev/null

echo "[*] Starting correct Tor service..."
sudo systemctl enable tor
sudo systemctl restart tor

sleep 2

echo "[*] Checking Tor status..."
systemctl status tor --no-pager

echo "[*] Checking tools..."

TOOLS=("chromium" "xdotool" "wmctrl" "xdpyinfo" "curl")

for tool in "${TOOLS[@]}"; do
    if command -v $tool >/dev/null 2>&1; then
        echo "✔ $tool OK"
    else
        echo "✘ $tool MISSING"
    fi
done

echo "[*] Setting script permissions..."

if [ -f "./Swarm.sh" ]; then
    chmod +x Swarm.sh
    echo "✔ Swarm.sh is ready"
else
    echo "⚠ insta_tor3.sh not found in current folder"
fi

echo ""
echo "======================================"
echo "        SETUP COMPLETED"
echo "======================================"
echo -e "\e[1;32m✔ System is ready for insta_tor3.sh\e[0m"
