#!/bin/bash
echo "Welcome to Kickstarter"
sudo pacman -Syu
sudo pacman -S tor nyx torbrowser-launcher torsocks
sudo systemctl enable tor.service
curl -O https://blackarch.org/strap.sh
echo bbf0a0b838aed0ec05fff2d375dd17591cbdf8aa strap.sh | sha1sum -c
chmod +x strap.sh
sudo ./strap.sh
## to be implemented, a file checker for /etc/pacman.conf to edit and enable multilib updating accross repositories 
echo "About to install Omarchy as the main arch linux brew..."
echo "Tip: for a quick and easy navigation guide or help menu, you can always press "SUPER + k" this will launch Omarchy's help menu"

wget -qO- https://omarchy.org/install | bash
echo "Kickstarter is almost done, wait for the system to finish updating then you can reboot the system and unplug the flash drive when it is off"
sudo pacman -Syu
