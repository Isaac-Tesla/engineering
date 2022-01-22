#!/bin/bash

echo "Install Helm"
snap install helm --classic
helm repo add stable https://charts.helm.sh/stable
helm repo update