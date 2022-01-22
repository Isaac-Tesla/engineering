#!/usr/bin/env bash

<<COMMENT

  Summary:
  The following code will install the Microsoft MSSQL drivers
    for Ubuntu 20.04 LTS.
 
  Note: If these drivers are not compatible, FreeTDS is another
    option.

COMMENT


curl https://packages.microsoft.com/keys/microsoft.asc --insecure | apt-key add -
curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list --insecure > /etc/apt/sources.list.d/mssql-release.list
apt-get -y update
ACCEPT_EULA=Y apt-get -y install msodbcsql17
ACCEPT_EULA=Y apt-get -y install mssql-tools