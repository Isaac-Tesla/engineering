#!/usr/bin/env bash


<<COMMENT

  Summary:
    The following code will install GoLang

  Instructions:
    https://www.digitalocean.com/community/tutorials/how-to-install-go-on-ubuntu-20-04
  
  SHA checksum:
    sha = e85278e98f57cdb150fe8409e6e5df5343ecb13cebf03a5d5ff12bd55a80264f

COMMENT


GO_VERSION=go1.18.linux-amd64.tar.gz

curl -OL https://go.dev/dl/${GO_VERSION}
sha256sum ${GO_VERSION}
sudo tar -C /usr/local -xvf ${GO_VERSION}

echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.profile
source ~/.profile
go version

rm ${GO_VERSION}