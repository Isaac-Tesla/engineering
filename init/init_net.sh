#!/usr/bin/env bash


<<COMMENT

  Summary:
    Installs .Net packages for Ubuntu 21.04 compatibility.

  References:
    - https://docs.microsoft.com/en-us/dotnet/core/install/linux-ubuntu

  After install:
    dotnet new --help

COMMENT


wget https://packages.microsoft.com/config/ubuntu/21.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
apt-get update; \
  apt-get install -y apt-transport-https && \
  apt-get update && \
  apt-get install -y dotnet-sdk-6.0 aspnetcore-runtime-6.0
