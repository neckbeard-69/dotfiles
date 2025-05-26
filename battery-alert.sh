#!/bin/bash

notify-send --urgency=low "Script Started" "Battery alert script is now running"
# Get path
path="$( dirname "$(readlink -f "$0")" )"
while [[ 0 -eq 0 ]]; do
	battery_status="$(cat /sys/class/power_supply/BAT0/status)"
	battery_charge="$(cat /sys/class/power_supply/BAT0/capacity)"

	if [[ $battery_status == 'Discharging' && $battery_charge -le 85 ]]; then
		if   [[ $battery_charge -le 15 ]]; then
			notify-send --urgency=critical "Battery critical!" "${battery_charge}%"
			sleep 180
		elif [[ $battery_charge -le 25 ]]; then
			notify-send --urgency=critical "Battery critical!" "${battery_charge}%"
			sleep 240
		elif [[ $battery_charge -le 40 ]]; then
			notify-send "Battery low!" "${battery_charge}%"
			sleep 360
		elif [[ $battery_charge -le 60 ]]; then
			notify-send "Battery low!" "${battery_charge}%"
			sleep 480
			notify-send "Battery low!" "${battery_charge}%"
			sleep 600
		fi
	else
		sleep 600
	fi
done
