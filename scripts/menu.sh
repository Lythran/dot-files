#!/usr/bin/env bash

power() {
	while true; do
		choice=$(gum choose "Restart" "Shutdown" "Back")
		case $choice in
			"Restart") systemctl reboot ;;
			"Shutdown") systemctl poweroff ;;
			"Back") break ;;
		esac
	done
}

while true; do
	choice=$(gum choose --header "What do you want to do?" "Update All" "Update Mirrors" "Web Apps" "Power Options" "Exit")
	case $choice in
		"Update All") $HOME/scripts/update.sh ;;
		"Power Options") power ;;
		"Update Mirrors") sudo reflector --latest 200 --country "United States" --sort rate --protocol https --age 24 --download-timeout 10 --save /etc/pacman.d/mirrorlist ;;
		"Web Apps") $HOME/scripts/pwa.sh;;
		"Exit") break ;;
	esac
done
