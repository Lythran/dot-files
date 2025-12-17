#!/usr/bin/env bash

# Get available Brave profiles
PROFILE_DIR="$HOME/.config/BraveSoftware/Brave-Browser"
PROFILES=($(find "$PROFILE_DIR" -maxdepth 1 -type d \( -name "Profile *" -o -name "Default" \) | 
sort))
PROFILE_NAMES=()
for profile in "${PROFILES[@]}"; do
    PROFILE_NAMES+=("$(basename "$profile")")
done

# Get input (interactive or arguments)
if [ "$#" -lt 3 ]; then
    echo -e "\e[32mCreate a Brave PWA\e[0m\n"
    APP_NAME=$(gum input --prompt "Name> " --placeholder "My Web App")
    APP_URL=$(gum input --prompt "URL> " --placeholder "https://example.com")
    ICON_URL=$(gum input --prompt "Icon URL> " --placeholder "https://icon.png")
    PROFILE=$(gum choose "$(ls -d "$PROFILE_DIR"/Profile* "$PROFILE_DIR"/Default 2>/dev/null | 
awk -F'/' '{print $NF}' | sort)" --no-limit)
else
    APP_NAME="$1"
    APP_URL="$2"
    ICON_URL="$3"
    PROFILE="${4:-Default}"
fi

[[ -z "$APP_NAME" || -z "$APP_URL" || -z "$ICON_URL" ]] && echo "Missing required fields!" && 
exit 1

# Download icon
ICON_DIR="$HOME/.local/share/applications/icons"
mkdir -p "$ICON_DIR"
ICON_PATH="$ICON_DIR/$APP_NAME.png"
curl -sL -o "$ICON_PATH" "$ICON_URL" || { echo "Icon download failed!"; exit 1; }

# Create .desktop file
DESKTOP_FILE="$HOME/.local/share/applications/$APP_NAME.desktop"
cat >"$DESKTOP_FILE" <<EOF
[Desktop Entry]
Name=$APP_NAME
Exec=/usr/bin/brave --profile-directory="$PROFILE" --app="$APP_URL"
Icon=$ICON_PATH
Terminal=false
Type=Application
Categories=Web;
EOF

chmod +x "$DESKTOP_FILE"
echo -e "\e[32m✓ $APP_NAME created! Launch with SUPER + SPACE\e[0m"
