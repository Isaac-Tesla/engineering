#!/usr/bin/env bash

<<COMMENT

  Summary:
  The following code will setup Ubuntu for personal use.

  Installation includes:
  - MPEG4
  - Wine
  - Vulkan GPU Drivers
  - Moving the Ubuntu dock to the left side from the right side.
  - Adding Gnome-tweaks to enable clearing all icons.

COMMENT

apt-get update
apt-get install -y ubuntu-restricted-extras ffmpeg
dpkg --add-architecture i386
wget -qO - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add -
apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
apt update
apt install --install-recommends winehq-devel
apt install libvulkan1 mesa-vulkan-drivers vulkan-utils
gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top true
apt-get install gnome-tweaks