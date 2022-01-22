#!/usr/bin/env bash

echo "Installing the AWS CLi tool..."
PWD=$(pwd)
mkdir $HOME/.aws
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "$HOME/awscliv2.zip"
unzip $HOME/awscliv2.zip
cp -r $PWD/aws/* $HOME/.aws
rm -rf $PWD/aws
bash $HOME/.aws/install --update