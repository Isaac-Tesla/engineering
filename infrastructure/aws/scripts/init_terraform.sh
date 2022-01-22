#!/bin/bash

echo "Install Terraform - Get the latest release. Note this must be manually kept up to date."
TF_VERSION=1.1.2
wget https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip
apt install zip -y
unzip terraform_${TF_VERSION}_linux_amd64.zip
mv terraform /usr/local/bin/
rm terraform_${TF_VERSION}_linux_amd64.zip
terraform version
echo "Add extra Terraform plugin for Snowflake"
curl https://raw.githubusercontent.com/chanzuckerberg/terraform-provider-snowflake/main/download.sh | bash -s -- -b $HOME/.terraform.d/plugins