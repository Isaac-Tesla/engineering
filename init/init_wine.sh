#!/usr/bin/env bash

<<COMMENT

  Summary:
    Sets up the latest version of Wine in Ubuntu.

COMMENT


sudo apt-get update

# Install Wine
# winecfg <- Then "cancel", set as Windows 10
sudo dpkg --add-architecture i386
wget -nc https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources
sudo mv winehq-jammy.sources /etc/apt/sources.list.d/
wget -nc https://dl.winehq.org/wine-builds/winehq.key
sudo mv winehq.key /usr/share/keyrings/winehq-archive.key
sudo apt update
# sudo apt install --install-recommends winehq-stable
sudo apt install -y wine-stable  

# For running windows environments
export WINEARCH=win32
export WINEPREFIX=~/.wine32
winecfg