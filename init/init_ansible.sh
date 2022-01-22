#!/usr/bin/env bash

<<COMMENT

  Summary:
  The following code will install the Ansible control node.

  A walkthrough for this setup can be found at:
  - https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-ansible-on-ubuntu-20-04

COMMENT


sudo apt update
sudo apt install ansible