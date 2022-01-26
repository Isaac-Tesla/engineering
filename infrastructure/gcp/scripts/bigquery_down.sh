#!/usr/bin/env bash

<<COMMENT

  Summary:
  The following code will use the existing GCP credentials to remove
	an existing BigQuery environment using Terraform.

  Note: Setup GCP Cli login prior to running this.

COMMENT


source ./functions/terraform_continue.sh

cd ./terraform
terraform init
terraform plan -out .terraform_plan
terraform_continue
terraform destroy -auto-approve