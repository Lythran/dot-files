#!/usr/bin/env bash

USERNAME="me"
HOSTS=("samba" "immich")

COMMAND="sudo apt update -y; sudo apt upgrade -y; sudo apt autoremove -y; docker compose pull; docker compose up -d; exit"

PROXMOX="root"
PROXMOX_HOST="192.168.1.12"
echo "Running on $PROXMOX_HOST"
ssh -l "$PROXMOX" -t "$PROXMOX_HOST" "$COMMAND"


for HOST in "${HOSTS[@]}"; do
    echo "Running on $HOST"
    ssh -l "$USERNAME" -t "$HOST" "$COMMAND"
done
