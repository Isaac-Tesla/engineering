#!/usr/bin/env bash

<<COMMENT

  Summary:
  The following code will use the existing AWS credentials to delete
	an ELK stack using Terraform.

  Note: Setup AWS Cli login prior to running this.

COMMENT


export TF_VAR_s3_bucket_for_terraform_state_file="engineering-terraform-state-file"

echo "Initialising Terraform..."
cd ./terraform/elasticache
terraform init \
	-backend-config="bucket=${TF_VAR_s3_bucket_for_terraform_state_file}"

terraform plan -out .terraform_plan

read -p "If you continue the displayed plan will be removed. Continue? (y/n) " RESP
if [ "$RESP" = "y" ]; then
  echo "Continuing..."
else
  printf "\nStopping now.\n\n\n"
  exit 1
fi

terraform destroy -auto-approve