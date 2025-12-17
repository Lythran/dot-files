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

install_or_remove() {
	while true; do
		choice=$(gum choose --header "Pacman & AUR packages" "Install" "Remove" "Back")
		case $choice in
			"Install") yay -S $(gum input --placeholder "Package name") ;;
			"Remove") yay -Yc && yay -Rns $(gum input --placeholder "Package to remove");;
			"Back") break ;;
		esac
	done
}

while true; do
	choice=$(gum choose --header "What do you want to do?" "Update All" "Update Mirrors" "Power Options" "System Packages" "Web & Desktop Apps" "Exit")
	case $choice in
		"Update All") yay -Syu ;;
		"Power Options") power ;;
		"Update Mirrors") sudo reflector --latest 200 --country "United States" --sort rate --protocol https --age 24 --download-timeout 10 --save /etc/pacman.d/mirrorlist ;;
		"System Packages") install_or_remove ;;
		"Web & Desktop Apps") $HOME/scripts/pwa.sh;;
		"Exit") break ;;
	esac
done
