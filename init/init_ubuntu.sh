#!/usr/bin/env bash

<<COMMENT

  Summary:
    Sets up Ubuntu 22.04 LTS.

COMMENT


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
  steam:i386 steam-devices btrfs-tools
