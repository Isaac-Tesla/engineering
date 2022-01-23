#!/usr/bin/env bash

<<COMMENT

  Summary:
  The following code will use the existing AWS credentials to add
	  Redshift using Terraform.

COMMENT


export TF_VAR_s3_bucket_for_terraform_state_file="engineering-terraform-state-file"

cd ./terraform/kinesis_redshift
terraform init \
	-backend-config="bucket=${TF_VAR_s3_bucket_for_terraform_state_file}"

terraform plan -out .terraform_plan

read -p "Is the Terraform plan okay to proceed with? (y/n) " RESP
if [ "$RESP" = "y" ]; then
  echo "Continuing with Terraform plan..."
else
  printf "\nStopping now.\n\n\n"
  exit 1
fi

terraform apply .terraform_plan