#!/bin/bash
sudo apt install bookworm
sudo su
apt update
apt full-upgrade
apt install --no-install-recommends sudo adduser
echo "user ALL=(ALL:ALL) NOPASSWD:ALL" | EDITOR=tee visudo -f /etc/sudoers.d/nopassword > /dev/null
/usr/sbin/addgroup --system console
/usr/sbin/adduser user console
sudo apt install console-data console-common kbd keyboard-configuration
sudo apt install extrepo
sudo extrepo enable kicksecure
sudo apt update && sudo apt full-upgrade
sudo apt install --no-install-recommends apt-transport-tor
ls -la /etc/apt/sources.list.d/extrepo_kicksecure.sources
