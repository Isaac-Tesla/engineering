#!/usr/bin/env bash

echo "Setup AWS Cli login prior to running this."

export TF_VAR_s3_bucket_for_terraform_state_file="engineering-terraform-state-file"

echo "Initialising Terraform..."
cd ./terraform/elasticache
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