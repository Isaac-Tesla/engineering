#!/usr/bin/env bash

# Install NVP
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
# Closing and refreshing the terminal may be required for it to recognise NVM.

# Install latest NodeJS
# Check for the latest version here -> https://nodejs.org/en/
nvm install 17.2.0

# Install npm & update to latest
# apt-get install -y nodejs
curl -sL https://deb.nodesource.com/setup_17.x | sudo -E bash -
npm install -g npm@latest
sudo apt install build-essential

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