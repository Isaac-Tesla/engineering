#!/usr/bin/env bash


<<COMMENT

  Summary:
  The following code will install the Azure command line interface.

  Note: Pass through the current subscription when running the 
    command.

    e.g. make sub=<subscriptionId> init_azure

COMMENT


SUBSCRIPTION=$1
curl -sL https://aka.ms/InstallAzureCLIDeb | bash
snap install kubectl --classic
az login
az account set --subscription $(SUBSCRIPTION)