#!/usr/bin/env bash

<<COMMENT

  Summary:
    Sets up Ubuntu 22.04 LTS just the way you want it.

  Reference:
    https://gist.github.com/rbialek/1012262

COMMENT

USER=$1
EMAIL=$2

git config --global user.email "${EMAIL}"
git config --global user.name "${USER}"

sudo apt-get update
sudo apt-get upgrade

sudo apt install -y \
  curl nano git make p7zip-full p7zip-rar \
  build-essential nghttp2 libnghttp2-dev libssl-dev \
  libgc1:i386 libgc1 libgupnp-av-1.0-3 libgupnp-dlna-2.0-4 \
  libldap-common libpython3-dev:i386 libpython3-dev \
  libtss2-tctildr0 libtss2-tcti-swtpm0 libtss2-tcti-mssim0 \
  libtss2-tcti-device0 libtss2-tcti-cmd0 libtss2-sys1 
  libtss2-rc0 libtss2-mu0 libtss2-fapi1 libtss2-esys-3.0.2-0 \
  python3-wheel-whl python3-setuptools-whl python3-pip-whl \
  steam:i386 steam-devices btrfs-tools lib32z1


# Setup config file for ssh
mkdir ~/.ssh

# Create config file for major vendors
cat << EOF > ~/.ssh/config
Host git-codecommit.*.amazonaws.com
  User <INSERT STRING FROM AWS HERE>
  IdentityFile ~/.ssh/<FILE NAME HERE>
  PubkeyAcceptedAlgorithms +ssh-rsa
  HostkeyAlgorithms +ssh-rsa

Host ssh.dev.azure.com
  IdentityFile ~/.ssh/<FILE NAME HERE>
  PubkeyAcceptedAlgorithms +ssh-rsa
  HostkeyAlgorithms +ssh-rsa

Host source.developers.google.com
  IdentityFile ~/.ssh/<FILE NAME HERE>
  PubkeyAcceptedAlgorithms +ssh-rsa
  HostkeyAlgorithms +ssh-rsa

Host github.com
  User git
  Hostname github.com
  PreferredAuthentications publickey
  IdentityFile /home/user/.ssh/<FILE NAME HERE>
EOF
