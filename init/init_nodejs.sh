#!/usr/bin/env bash

<<COMMENT

  Summary:
  The following code will install NodeJS & NPM through 
    NVM. This is due to the latest version in the 
    Ubuntu being relatively old in comparison.

  If you still desire to use the old version instead,
    run:

    apt-get install -y libodbc1 unixodbc unixodbc-dev npm nodejs
    npm install express --save

COMMENT


curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
nvm install 17.2.0
curl -sL https://deb.nodesource.com/setup_17.x | sudo -E bash -
npm install -g npm@latest
sudo apt install build-essential