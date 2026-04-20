#!/bin/bash

##################################
# Logo (Banner)
##################################
clear
echo -e "\e[1;31m"
echo "      _____ ______      ______         __  ___  ____  __  __ "
echo "     / ___//_  __/     / ___/ | /| / / /   | / __ \\/  |/  / "
echo "     \\__ \\  / /        \\__ \\ | |/ |/ / / /| |/ /_/ / /|_/ /  "
echo "    ___/ / / /        ___/ / |  /|  / / ___ / _, _/ /  / /   "
echo "   /____/ /_/        /____/  |__/|__/ /_/  |_/_/ |_/_/  /    "
echo -e "\e[1;37m                >> THE SWARM IS ACTIVE <<\e[0m"
echo -e "\e[1;31m                       ( ʘ益ʘ )  \e[0m"
echo -e "\e[1;36m----------------------------------------------------------\e[0m"
echo -e "\e[1;36m        FRAMEWORK FOR MULTI-SESSION AUTOMATION\e[0m"
echo -e "\e[1;36m----------------------------------------------------------\e[0m"

##################################
# User Input
##################################
echo -e "\e[1;33m[?] How many windows do you want to open? (1-12):\e[0m "
read -r NUM_SESSIONS

# Validate input (1-12)
if [[ ! "$NUM_SESSIONS" =~ ^[0-9]+$ ]] || [ "$NUM_SESSIONS" -lt 1 ] || [ "$NUM_SESSIONS" -gt 12 ]; then
    echo -e "\e[1;31m[!] Invalid input, opening 1 window by default.\e[0m"
    NUM_SESSIONS=1
fi

echo -e "\e[1;33m[?] Enter the website URL (or press Enter for Instagram):\e[0m "
read -r TARGET_URL
if [ -z "$TARGET_URL" ]; then
    TARGET_URL="https://www.instagram.com"
fi

##################################
# Torrc Check & Update (Automated)
##################################
echo -e "\e[1;36m[#] Checking Tor configuration...\e[0m"
TORRC="/etc/tor/torrc"
CHANGED=false

for (( p=0; p<NUM_SESSIONS; p++ )); do
    PORT=$((9050 + p))
    if ! grep -q "SocksPort $PORT" "$TORRC"; then
        echo -e "\e[1;33m[+] Adding SocksPort $PORT to $TORRC...\e[0m"
        echo "SocksPort $PORT" | sudo tee -a "$TORRC" > /dev/null
        CHANGED=true
    fi
done

if [ "$CHANGED" = true ]; then
    echo -e "\e[1;32m[!] Tor configuration updated. Restarting service...\e[0m"
    sudo systemctl restart tor
    sleep 2
else
    echo -e "\e[1;32m[✔] All ports are already configured.\e[0m"
fi

##################################
# Technical Window Settings
##################################
BASE_WIDTH=470
BASE_HEIGHT=349
GAP_X=10
GAP_Y=35

CHROME_BIN="chromium"
PROFILE_BASE="$HOME/.instagram-profile"
WIN_IDS=()

##################################
# Screen Calculation
##################################
SCREEN_WIDTH=$(xdpyinfo | awk '/dimensions/{print $2}' | cut -d'x' -f1)
COLS=$(( SCREEN_WIDTH / BASE_WIDTH ))
[ $COLS -lt 1 ] && COLS=1

##################################
# Cleanup on Ctrl+C
##################################
cleanup() {
  echo -e "\n\e[1;31m🛑 Closing all windows and stopping the Swarm...\e[0m"
  for WIN in "${WIN_IDS[@]}"; do
    wmctrl -ic "$WIN"
  done
  exit 0
}
trap cleanup SIGINT

##################################
# Launching Windows
##################################
echo -e "\e[1;34m[>] Launching $NUM_SESSIONS sessions on: $TARGET_URL\e[0m"

for (( i=0; i<NUM_SESSIONS; i++ )); do
  TOR_PORT=$((9050 + i))
  PROFILE_DIR="${PROFILE_BASE}${i}"
  mkdir -p "$PROFILE_DIR"

  $CHROME_BIN \
    --user-data-dir="$PROFILE_DIR" \
    --new-window "$TARGET_URL" \
    --proxy-server="socks5://127.0.0.1:${TOR_PORT}" \
    --host-resolver-rules="MAP * ~NOTFOUND , EXCLUDE 127.0.0.1" \
    --no-first-run \
    --disable-infobars &

  PID=$!
  sleep 1.8 # Delay to ensure window stability

  # Search for Window ID
  WIN_ID=$(xdotool search --onlyvisible --pid $PID | head -n 1)
  [ -z "$WIN_ID" ] && continue

  WIN_IDS+=("$WIN_ID")

  COL=$(( i % COLS ))
  ROW=$(( i / COLS ))
  X=$(( COL * BASE_WIDTH + GAP_X ))
  Y=$(( ROW * BASE_HEIGHT + GAP_Y ))

  xdotool windowsize "$WIN_ID" $((BASE_WIDTH - GAP_X)) $((BASE_HEIGHT - GAP_Y))
  xdotool windowmove "$WIN_ID" "$X" "$Y"
done

echo -e "\e[1;32m\n🧅 Swarm is now running successfully (Multi-IP Active)\e[0m"
echo -e "\e[1;37mPress Ctrl+C to exit and close all sessions.\e[0m"

while true; do sleep 1; done
