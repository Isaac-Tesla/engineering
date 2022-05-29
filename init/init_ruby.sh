#!/usr/bin/env bash

<<COMMENT

  Summary:
  The following code will install Ruby on rails.

  Reference:
    - https://phoenixnap.com/kb/install-ruby-ubuntu

COMMENT


sudo apt update
sudo apt install -y ruby-full
ruby --version