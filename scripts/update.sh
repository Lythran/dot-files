#!/usr/bin/env bash

update_aur() {
	repos=(
		jellyfin-desktop
		vscodium
		localsend-bin
		python311
	)

	for repo in "${repos[@]}"; do
		cd "$HOME/repos/$repo" || continue
		git fetch
		if [[ $(git rev-parse HEAD) != $(git rev-parse @{u}) ]]; then
		    echo "Updating: $repo"
		    git pull && makepkg -si --noconfirm
		else
		    echo "Up to date: $repo"
		fi
	done
}

sudo pacman -Syu
update_aur   
