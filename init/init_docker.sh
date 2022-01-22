#!/bin/bash


<<COMMENT

  Summary:
  The following code will install Docker and Docker-Compose to 
    use for testing docker containers and building dockerfiles.

  NOTE: Permissions will also be added to the current user to 
    enable them to run docker commands with the docker group.

COMMENT


apt -y install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg --insecure | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
apt-get update
apt-get -y install docker-ce docker-ce-cli containerd.io
curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
chmod 666 /var/run/docker.sock
ME=$(whoami)
usermod -aG docker $ME