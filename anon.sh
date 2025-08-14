#!/bin/bash
echo "Welcome to Kickstarter"
sudo pacman -Syu
sudo pacman -S tor nyx torbrowser-launcher torsocks
sudo systemctl start tor
sudo systemctl enable --now tor.service
systemctl status tor.service
ss -nlt
wget -qO - https://api.ipfy.org; echo "Your IP address is:"
torsocks wget -qO - https://api.ipfy.org; echo "Your IP address is:"
source torsocks on
wget -qO - https://api.ipfy.org; echo "Check if you are using Tor"
echo ". torsocks on" >> ~/.bashrc
sudo pacman -S gnu-netcat
echo -e 'PROTOCOLINFO\r\n' | nc 127.0.0.1 9051
