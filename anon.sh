#!/bin/bash
sudo pacman -Syu
sudo pacman -S tor nyx torbrowser-launcher
sudo systemctl start tor
sudo systemctl enable --now tor.service
systemctl status tor.service