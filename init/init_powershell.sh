#!/usr/bin/env bash

<<COMMENT

  Summary:
    Installs and sets up powershell with Azure Cli tooling.

  For Ubuntu 20.04 LTS.

  https://docs.microsoft.com/en-us/powershell/scripting/install/install-ubuntu?view=powershell-7.2

COMMENT


# Update the list of packages
sudo apt-get update
# Install pre-requisite packages.
sudo apt-get install -y wget apt-transport-https software-properties-common
# Download the Microsoft repository GPG keys
wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb
# Register the Microsoft repository GPG keys
sudo dpkg -i packages-microsoft-prod.deb
# Update the list of packages after we added packages.microsoft.com
sudo apt-get update
# Install PowerShell
sudo apt-get install -y powershell
# Remove download
rm packages-microsoft-prod.deb
# Start PowerShell
pwsh
# Check version $PSVersionTable.PSVersion

# Install the Azure module in powershell
# https://docs.microsoft.com/en-us/powershell/azure/install-az-ps?view=azps-7.4.0
# Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force
# Install-Module -Name Az.ManagedServiceIdentity

# Sign-in
# Connect-AzAccount