#!/usr/bin/env bash

notify-send "Open Web UI" "Starting Open web UI..."
sleep 5s
makoctl dismiss --all

cd "$HOME/repos/open web ui"/ && source bin/activate && open-webui serve

sleep 2s

notify-send "Open Web UI" "Started successfully!"
makoctl dismiss --all
