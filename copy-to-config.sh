#!/bin/bash
echo "Copying to ~/.config folder..."
sleep 3 
echo "Copying hyprland config..."
cp -rf hypr ~/.config
echo "Copying rofi config..."
cp -rf rofi ~/.config
echo "Copying waybar config..."
cp -rf waybar ~/.config
echo "Copying swappy to config..."
cp -rf swappy ~/.config
echo "Completed! be sure to check the config files over at ~/.config and tweak it as you wish"
