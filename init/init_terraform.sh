#!/bin/bash

<<COMMENT

  Summary:
  The following code will install Terraform.

  Note: Extra plugins are added at the end of the code,
    e.g. Snowflake plugin.

COMMENT


TF_VERSION=1.2.1
wget https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip
sudo apt install zip -y
unzip terraform_${TF_VERSION}_linux_amd64.zip
sudo mv terraform /usr/local/bin/
rm terraform_${TF_VERSION}_linux_amd64.zip
terraform version

# Plugins
curl https://raw.githubusercontent.com/chanzuckerberg/terraform-provider-snowflake/main/download.sh | sudo bash -s -- -b $HOME/.terraform.d/plugins