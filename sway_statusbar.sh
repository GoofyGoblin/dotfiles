
#!/bin/sh

while true
do
clock=$(date '+%I')

case "$clock" in
	"00") icon="🕛 " ;;
	"01") icon="🕐 " ;;
	"02") icon="🕑 " ;;
	"03") icon="🕒 " ;;
	"04") icon="🕓 " ;;
	"05") icon="🕔 " ;;
	"06") icon="🕕 " ;;
	"07") icon="🕖 " ;;
	"08") icon="🕗 " ;;
	"09") icon="🕘 " ;;
	"10") icon="🕙 " ;;
	"11") icon="🕚 " ;;
	"12") icon="🕛 " ;;
esac

case $BLOCK_BUTTON in
	1) notify-send "This Month" "$(cal | sed "s/\<$(date +'%e'|tr -d ' ')\>/<b><span color='red'>&<\/span><\/b>/")" && notify-send "Appointments" "$(calcurse -d3)" ;;
	2) setsid -f "$TERMINAL" -e calcurse ;;
	3) notify-send "Time/date module" "\- Left click to show upcoming appointments for the next three days via \`calcurse -d3\` and show the month via \`cal\`
- Middle click opens calcurse if installed" ;;
	6) setsid -f "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

echo "$icon$(date '+%I:%M')"


case $BLOCK_BUTTON in
	1) notify-send " CPU hogs" "$(ps axch -o cmd,%cpu | awk '{cmd[$1]+=$2} END {for (i in cmd) print i, cmd[i]}' | sort -nrk2  | head)\\n(100% per core)" ;;
	2) setsid -f "$TERMINAL" -e htop ;;
	3) notify-send " CPU module " "\- Shows CPU temperature.
- Click to show intensive processes.
- Middle click to open htop." ;;
	6) setsid -f "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

sensors | awk '/Core 0/ {print " " $3}'


location=${1:-/}

[ -d "$location" ] || exit

case $BLOCK_BUTTON in
	1) notify-send "󰗮 Disk space" "$(df -h --output=target,used,size)" ;;
	3) notify-send "󰗮 Disk module" "\- Shows used hard drive space.
- Click to show all disk info." ;;
	6) setsid -f "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

case "$location" in
	"/home"* ) icon="󰗮 " ;;
	"/mnt"* ) icon="󰗮 " ;;
	*) icon="󰗮 ";;
esac

filter() { sed "/^volume:/d;s/\\[paused\\].*/⏸/g;/\\[playing\\].*/d;/^ERROR/Q" | paste -sd ' ' -;}

pidof -x sb-mpdup >/dev/null 2>&1 || sb-mpdup >/dev/null 2>&1 &

case $BLOCK_BUTTON in
	1) mpc status | filter ; setsid -f "$TERMINAL" -e ncmpcpp ;;  # right click, pause/unpause
	2) mpc toggle | filter ;;  # right click, pause/unpause
	3) mpc status | filter ; notify-send " Music module" "\-Shows mpd song playing.
-  when paused.
- Left click opens ncmpcpp.
- Middle click pauses.
- Scroll changes track.";;  # right click, pause/unpause
	4) mpc prev   | filter ;;  # scroll up, previous
	5) mpc next   | filter ;;  # scroll down, next
	6) mpc status | filter ; setsid -f "$TERMINAL" -e "$EDITOR" "$0" ;;
	*) mpc status | filter ;;
esac

case $BLOCK_BUTTON in
	1) "$TERMINAL" -e nmtui; pkill -RTMIN+4 dwmblocks ;;
	3) notify-send "Internet module" "\- Click to connect
❌: wifi disabled
📡: no wifi connection
📶: wifi connection with quality
❎: no ethernet
🌐: ethernet working
🔒: vpn is active
" ;;
	6) setsid -f "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

# Wifi
if [ "$(cat /sys/class/net/w*/operstate 2>/dev/null)" = 'up' ] ; then
	wifiicon="$(awk '/^\s*w/ { print "", int($3 * 100 / 70) "% " }' /proc/net/wireless)"
elif [ "$(cat /sys/class/net/w*/operstate 2>/dev/null)" = 'down' ] ; then
	[ "$(cat /sys/class/net/w*/flags 2>/dev/null)" = '0x1003' ] && wifiicon="󰤟" || wifiicon="❌ "
fi

# Ethernet
[ "$(cat /sys/class/net/e*/operstate 2>/dev/null)" = 'up' ] && ethericon="󰈀" || ethericon="❌ "  


# TUN
[ -n "$(cat /sys/class/net/tun*/operstate 2>/dev/null)" ] && tunicon=""

printf "%s%s%s\n" "$wifiicon" "$ethericon" "$tunicon"

case $BLOCK_BUTTON in
	3) notify-send "🔋 Battery module" "🔋: discharging
🛑: not charging
♻: stagnant charge
🔌: charging
⚡: charged
❗: battery very low!
- Scroll to change adjust xbacklight." ;;
	4) xbacklight -inc 10 ;;
	5) xbacklight -dec 10 ;;
	6) setsid -f "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

# Loop through all attached batteries and format the info
for battery in /sys/class/power_supply/BAT?*; do
	# If non-first battery, print a space separator.
	[ -n "${capacity+x}" ] && printf " "
	# Sets up the status and capacity
	case "$(cat "$battery/status" 2>&1)" in
		"Full") status="⚡" ;;
		"Discharging") status="󱟞 " ;;
		"Charging") status="⚡" ;;
		"Not charging") status="󰂂 " ;;
		"Unknown") status="󰂑 " ;;
		*) exit 1 ;;
	esac
	capacity="$(cat "$battery/capacity" 2>&1)"
	# Will make a warn variable if discharging and low
	[ "$status" = "󱟞 " ] && [ "$capacity" -le 25 ] && warn="󰂃 "
	# Prints the info
	printf "%s%s%d%%" "$status" "$warn" "$capacity"; unset warn
done && printf "\\n"

done
