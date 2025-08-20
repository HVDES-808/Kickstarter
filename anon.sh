#!/bin/bash

# Kickstarter: BlackArch + Omarchy Setup Script
# Author: sudohades
# Date: 2025-08-20
#
# Description:
#   Automates the installation of BlackArch and Omarchy on an existing Arch Linux system,
#   providing a cybersecurity toolkit and minimal desktop environment.
#
# Usage:
#   sudo ./anon.sh
#
# Requirements:
#   - Must be run as root or with sudo
#   - Internet connection required
#
# Warning:
#   This script will update your system and install many packages.

set -euo pipefail
LOGFILE="/var/log/kickstarter.log"
exec > >(tee -a "$LOGFILE") 2>&1
echo "Welcome to Kickstarter"
echo "[INFO] Starting BlackArch and Omarchy installation..."

update_system() {
   read -rp "About to update all system dependecies and packages. Continue? [y/N]: " confirm
        if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
            echo "Aborting."
            exit 1
        fi
    sudo pacman -Syu
}

install_blackarch(){
    curl -O https://blackarch.org/strap.sh
    echo bbf0a0b838aed0ec05fff2d375dd17591cbdf8aa strap.sh | sha1sum -c
    chmod +x strap.sh
    read -rp "About to install blackarch system programs and tools. Continue? [y/N]: " confirm
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then 
        echo "Aborting."
        exit 1
        fi

    sudo ./strap.sh
    ## to be implemented, a file checker for /etc/pacman.conf to edit and enable multilib updating accross repositories 
    echo "[*] Enabling multilib repository..."
    PACMAN_CONF="/etc/pacman.conf"
    if ! grep -q "^\[multilib\]" "$PACMAN_CONF"; then
        echo "Enabling [multilib] repository in $PACMAN_CONF"
        cp "$PACMAN_CONF" "{PACMAN_CONF}.bak"
        sed -i '/#\[multilib\]/,/#Include = \/etc\/pacman.d\/mirrorlist/{
            s/^#//
            }' "$PACMAN_CONF"
        fi
    rm -rf strap.sh
}

echo "About to install Omarchy as the main arch linux brew..."
echo "Tip: for a quick and easy navigation guide or help menu, you can always press "SUPER + k" this will launch Omarchy's help menu"
read -rp "Continue? [y/N]: " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then 
    echo "Aborting."
    exit 1
    fi

install_omarchy(){
    wget -qO- https://omarchy.org/install | bash
}

clean_up(){
    echo "[*] Cleaning up system"
    sudo pacman -Rns $(pacman -Qtdq) --noconfirm || true
    sudo pacman -Sc --noconfirm
}

main(){
    update_system
    install_blackarch
    install_omarchy
    clean_up
}

echo "Kickstarter is almost done, wait for the system to finish updating then you can reboot the system and unplug the flash drive when it is off"
sudo pacman -Syu
echo "Done, you can now reboot the system. To install specific blackarch packages use \"pacman -Ss <package_name>\""

main "$@"