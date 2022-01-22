#!/usr/bin/env bash

<<COMMENT

  Summary:
  The following code will install .NET in Linux to enable the use of C#.

  The install instructions for this can be found at:
  - https://docs.microsoft.com/en-us/dotnet/core/install/linux-ubuntu

  To test/confirm setup complete, run:

        dotnet new --help

COMMENT


wget https://packages.microsoft.com/config/ubuntu/21.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
apt-get update; \
  apt-get install -y apt-transport-https && \
  apt-get update && \
  apt-get install -y dotnet-sdk-6.0 aspnetcore-runtime-6.0