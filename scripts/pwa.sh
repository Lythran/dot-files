#!/usr/bin/env bash

install() {
	echo -e "Make a PWA using Brave"

	name=$(gum input --prompt "Name: " --placeholder "My favorite web app")
	url=$(gum input --prompt "URL: " --placeholder "https://example.com")
	profile_dir=$(echo -e "Default\n$(ls -d "$HOME/.config/BraveSoftware/Brave-Browser"/Profile* | awk -F'/' '{print $NF}')" | gum filter --limit=1 --placeholder="Select a profile...")
	INTERACTIVE_MODE=true

	if [[ -z "$name" || -z "$url" ]]; then
		echo "You must set name AND Url!"
		exit 1
	fi

	desktop="$HOME/.local/share/applications/$name.desktop"

	cat >"$desktop" <<EOF
[Desktop Entry]
Version=1.0
Name=$name
Comment=$name
Exec=/usr/bin/brave --profile-directory="$profile_dir" --app="$url"
Terminal=false
Type=Application
StartupNotify=true
EOF

	chmod +x "$desktop"
}

remove() {
	choices=$(grep -l "/usr/bin/brave" "$HOME/.local/share/applications/"*.desktop | xargs -I {} basename -s .desktop {} ; echo "Back")

	if [ -z "$(grep -l /usr/bin/brave $HOME/.local/share/applications/*.desktop)" ]; then
		inst_choice=$(gum choose --header="No PWA desktop entry found. Would you like to install one?" "Yes" "No")
		case $inst_choice in
			"Yes") install && return 0;;
			"No") return 0 ;;
		esac
	fi

	name=$(printf '%s\n' "${choices[@]}" | gum filter --placeholder="Select a PWA...")

	if [[ "$name" == "Back" ]]; then
		return 0	
	fi

	desktop=$HOME/.local/share/applications/$name.desktop
	rm -v "$desktop"
	echo -e "Removed $desktop"
}

while true; do
	choice=$(gum choose --header="Install or Remove PWA using Brave" "Install" "Remove" "Back")
	case $choice in
		"Install") install ;;
		"Remove") remove ;;
		"Back") break ;;
	esac
done
