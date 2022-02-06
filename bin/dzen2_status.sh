#!/bin/sh

# ------------------------------------------------------
# file:     $HOME/.scripts/dzenstat.sh
# author:   Ramon Solis - http://cyb3rpunk.wordpress.com
# modified: June 2011
# vim:fenc=utf-8:nu:ai:si:et:ts=4:sw=4:ft=sh:
# debug: pkill dzen2 & sh dzen2.sh
# ------------------------------------------------------

# -------------------------
# Dzen settings & Variables
# -------------------------
ICONPATH="$HOME/.icons/dzen2-icons"
COLOR_ICON="#a01416"
SEPARATOR_COLOR="#ff0a0a"
GOOD_COLOR="#00ff00"
MODERATE_COLOR="#ffff00"
CRIT_COLOR="#ff0000"	# Default: #ff2c4a
DZEN_FG="#ffffff"
DZEN_BG="#101010"
HEIGHT=19	# Default: 12
WIDTH=1000	# Default: 470
RESOLUTIONW=`xrandr | grep "current" | awk '{print $8}'` 
RESOLUTIONH=`xrandr | grep "current" | awk '{print $10}' | tr -d ','`
X=$(($RESOLUTIONW-$WIDTH))
#Y=$(($RESOLUTIONH-$HEIGHT-1))	# Bottom right corner
Y=0	# Top right corner
BAR_FG="#ffffff"
BAR_BG="#808080"
BAR_H=10
BAR_W=60
FONT="-jmk-Neep-Bold-R-Normal--13-120-75-75-c-60-iso8859-1"
SLEEP=1
#VUP="amixer -c0 -q set Master 4dB+"
#VDOWN="amixer -c0 -q set Master 4dB-"
#EVENT="button3=exit;button4=exec:$VUP;button5=exec:$VDOWN"
DZEN="dzen2 -fn $FONT -bg $DZEN_BG -fg $DZEN_FG -p -w $WIDTH -h $HEIGHT -x $X -y $Y -ta r"
# -x 920 -y 0

# -------------
# Infinite loop
# -------------
while :; do
sleep ${SLEEP}

# ---------
# Functions
# ---------
#Vol ()
#{
#	ONF=$(amixer get Master | awk '/Front\ Left:/ {print $7}' | tr -d '[]')
#	VOL=$(amixer get Master | awk '/Front\ Left:/ {print $5}' | tr -d '[]%')
#		if [[ ${ONF} == 'off' ]] ; then
#		   echo -n "^fg($CRIT_COLOR)^i($ICONPATH/spkr_01.xbm)^fg()" $(echo "0"  | gdbar -fg $BAR_FG -bg $BAR_BG -h $BAR_H -w $BAR_W -s o -ss 1 -sw 2 -nonl)
#		else
#		   echo -n "^fg($COLOR_ICON)^i($ICONPATH/spkr_01.xbm)^fg()" ${VOL} $(echo $VOL | gdbar -fg $BAR_FG -bg $BAR_BG -h $BAR_H -w $BAR_W -s o -ss 1 -sw 2 -nonl)
#		fi
#    return
#}

Mem ()
{
	#MEM=$(free -m | grep 'Mem' | tr -s '[:blank:]' | awk '{print $3, "M"}')
	MEM=$(free -h --si | grep 'Mem:' | tr -s '[:blank:]' | awk '{print substr($3, 1, length($3)-1), substr($3, length($3), 1)}')
	echo -n "^fg($COLOR_ICON)^i($ICONPATH/mem.xbm)^fg() ${MEM}"
	return
}

Temp ()
{
	TEMP=$(acpi -t | awk '{print $4}' | tr -d '.0')
		if [[ ${TEMP} -gt 63 ]] ; then
			echo -n "^fg($CRIT_COLOR)^i($ICONPATH/temp.xbm)^fg($CRIT_COLOR) ${TEMP}°C" $(echo ${TEMP} | gdbar -fg $CRIT_COLOR -bg $BAR_BG -h $BAR_H -s v -sw 5 -ss 0 -sh 1 -nonl)
		else 
			echo -n "^fg($COLOR_ICON)^i($ICONPATH/temp.xbm)^fg() ${TEMP}°C" $(echo ${TEMP} | gdbar -fg $BAR_FG -bg $BAR_BG -h $BAR_H -s v -sw 5 -ss 0 -sh 1 -nonl)
		fi
	return
}

Disk ()
{
	SDA5=$(df -h / | awk '/\/$/ {print $5}' | tr -d '%')
	if [[ ${SDA5} -gt 60 ]] ; then
		echo -n "^fg($COLOR_ICON)^i($ICONPATH/fs_01.xbm)^fg() /:${SDA5}% $(echo $SDA5 | gdbar -fg $CRIT_COLOR -bg $BAR_BG -h 7 -w 40 -s o -ss 0 -sw 2 -nonl)"
	else
		echo -n "^fg($COLOR_ICON)^i($ICONPATH/fs_01.xbm)^fg() /:${SDA5}% $(echo $SDA5 | gdbar -fg $BAR_FG -bg $BAR_BG -h 7 -w 40 -s o -ss 0 -sw 2 -nonl)"
	fi
	return
}

Wifi ()
{
	WIFI_INFO=$(iw dev wlp4s0 link)
	if [ "${WIFI_INFO}" = "Not connected." ] ; then
		echo -n "^fg($COLOR_ICON)^i($ICONPATH/wifi_02.xbm)^fg($CRIT_COLOR) down"
	else
		ESSID=$(echo "${WIFI_INFO}" | grep 'SSID:' | awk '{print $2}')
		QUALITY=$(nmcli dev wifi | grep "*" | tr -s '[:blank:]' | awk '{print $8}')
		if [[ ${QUALITY} -gt 50 ]] ; then
			QUALITY_COLOR=$GOOD_COLOR
		else
			QUALITY_COLOR=$MODERATE_COLOR
		fi
		echo -n "^fg($COLOR_ICON)^i($ICONPATH/wifi_02.xbm)^fg() ${ESSID} (^fg($QUALITY_COLOR)${QUALITY}%^fg())"
	fi
	return
}

Date ()
{
	DATE=$(date +"%Y-%m-%d")
	TIME=$(date +"%H:%M:%S")
	#TIME=$(date +"%Y-%m-%d %H:%M:%S")
	#TIME=$(date +%R)
	echo -n "^fg($COLOR_ICON)^i($ICONPATH/calendar_9x9.xbm)^fg($DZEN_FG) ${DATE} ^fg($COLOR_ICON)^i($ICONPATH/clock.xbm)^fg($DZEN_FG) ${TIME}"
	return
}

Battery ()
{
	BATTERY_PERCENT=$(acpi -b | grep 'Discharging,' | awk '{print $4}' | tr -d ',')
	if [ "${BATTERY_PERCENT}" = "" ] ; then
		BATTERY_PERCENT=$(acpi -b | grep 'Charging,' | awk '{print $4}' | tr -d ',')
		echo -n "^fg($COLOR_ICON)^i($ICONPATH/ac_01.xbm)^fg() ${BATTERY_PERCENT}"
	else
		echo -n "^fg($COLOR_ICON)^i($ICONPATH/bat_full_02.xbm)^fg() ${BATTERY_PERCENT}"
	fi
	return
}

Between ()
{
    echo -n " ^fg($SEPARATOR_COLOR)^r(2x10)^fg() "
	return
}

OSLogo ()
{
	#OS=$(uname -a | awk '{print $2}')
	#echo -n " ^fg($COLOR_ICON)^i($ICONPATH/${OS}.xbm)^fg()"
	echo -n " ^fg($COLOR_ICON)^i($ICONPATH/arch.xbm)^fg()"
	return
}
# --------- End Of Functions

# -----
# Print 
# -----
#Print () {
#		OSLogo
#        Between
#		Temp
#        Between
#        Mem
#        Between
#        Disk
#        Between
#        Vol
#        Between
#        Date
#        echo
#    return
#}

Print () {
	OSLogo
	Between
	Wifi
	Between
	Temp
	Between
	Battery
	Between
	Mem
	Between
	Disk
	Between
	Date
	echo
    return
}

echo "$(Print)" 
done | $DZEN &