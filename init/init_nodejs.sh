#!/usr/bin/env bash


<<COMMENT

  Summary:
    Installs NodeJS for Javascript using NVM as apt-get
    only has old version and is not updated. Also installs
    npm.

  References:
    - Check for the latest version here -> https://nodejs.org/en/

  Use:
    # Setup project
    npm init -y

    # Install packages
    npm i express ejs express-ejs-layouts

    # Add development dependency
    # nodemon allows a refresh of the server every time we make a change.
    npm i --save-dev nodemon

    # Install MongoDB connector
    npm i mongoose

    # Install dotenv
    npm i --save-dev dotenv

    # Install body-parser (to access input elements from our server)
    npm i body-parser

    # Install library to deal with multi-part forms
    npm i multer

COMMENT


# Install NVP
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
# Closing and refreshing the terminal may be required for it to recognise NVM.

# Install latest NodeJS
nvm install 18.2.0

# Install npm & update to latest
curl -sL https://deb.nodesource.com/setup_17.x | sudo -E bash -
npm install -g npm@latest
sudo apt install build-essential