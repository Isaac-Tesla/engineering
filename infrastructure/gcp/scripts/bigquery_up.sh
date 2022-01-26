#!/usr/bin/env bash

<<COMMENT

  Summary:
  The following code will use the existing GCP credentials to add
	  an BigQuery environment using Terraform.

COMMENT


source ./functions/terraform_continue.sh

cd ./terraform
terraform init
terraform plan -out .terraform_plan
terraform_continue
terraform apply .terraform_plan