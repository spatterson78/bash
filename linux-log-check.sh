#!/bin/bash
#
##########################################################
# Created By: Shawn Patterson
# Created On: 01/27/2023
# Filename: linux-log-check.sh
# Usage: ./linux-log-check.sh
# Description: Script to check for log entries
##########################################################

# Functions

journalctl-n10 () {
	echo
	echo "--------------------------------------------------------"
	echo "Showing 10 most recent log entries..."
	echo "--------------------------------------------------------"
	echo
	journalctl -n 10
	echo
	echo "--------------------------------------------------------"
	echo "Showing 10 most recent log entries comnpleted."
	echo "--------------------------------------------------------"
	echo
}

journalctl-crit () {
	echo
        echo "--------------------------------------------------------"
        echo "Showing critical log entries..."
        echo "--------------------------------------------------------"
        echo
        journalctl -p crit
        echo
        echo "--------------------------------------------------------"
        echo "Showing critical log entries comnpleted."
        echo "--------------------------------------------------------"
        echo
}

journalctl-service () {
        echo
	echo -n "Please enter the systemd service you wish to check: "
	read SERVICE
	echo
        echo "--------------------------------------------------------"
        echo "Showing $SERVICE log entries..."
        echo "--------------------------------------------------------"
        echo
        journalctl -u $SERVICE
        echo
        echo "--------------------------------------------------------"
        echo "Showing $SERVICE log entries comnpleted."
        echo "--------------------------------------------------------"
        echo
}

journalctl-service-crit () {
        echo
        echo -n "Please enter the systemd service you wish to check: "
        read SERVICE
        echo
        echo "--------------------------------------------------------"
        echo "Showing critical $SERVICE log entries..."
        echo "--------------------------------------------------------"
        echo
        journalctl -u $SERVICE -p crit
        echo
	echo "--------------------------------------------------------"
        echo "Showing critical $SERVICE log entries comnpleted."
	echo "--------------------------------------------------------"
        echo
}

# While loop to keep menu opne
while true
do
# Menu Display
	echo
	echo "--------------------------------------------------------"
	echo "Linux System Logs Menu:"
	echo "--------------------------------------------------------"
	echo
	echo "1. Display 10 most recent log entries"
	echo "2. Display critical log entries"
	echo "3. Display log entries for a systemd service"
	echo "4. Display crititcal log entries for a systemd service"
	echo "x. Exit Linux System Logs Menu"
	echo 
	echo "--------------------------------------------------------"

# Get menu entry
	echo -n "Enter Choice: "
	read SEL

# case statement to execute function 
	case $SEL in

		1)
			clear
			journalctl-n10
			;;
		2)
			clear
			journalctl-crit
			;;
		3)
			clear
			journalctl-service
			;;
		4)
			clear
			journalctl-service-crit
			;;
		x)
			echo
			echo "Exiting Linux System Log Menu..."
			sleep 1
			clear
			exit
			;;
		*)
			echo "Invalid Selection"
			;;
	esac
done
