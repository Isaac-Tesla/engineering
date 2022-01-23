#!/usr/bin/env bash

<<COMMENT

  Summary:
  The following code will use the existing AWS credentials to add
	a DynamoDB table using Terraform.

  Note: Setup AWS Cli login prior to running this.

COMMENT


export TF_VAR_s3_bucket_for_terraform_state_file="engineering-terraform-state-file"

cd ./terraform/dynamodb
terraform init \
	-backend-config="bucket=${TF_VAR_s3_bucket_for_terraform_state_file}"

terraform plan -out .terraform_plan

read -p "The Terraform plan will be deleted. Do you wish to continue? (y/n) " RESP
if [ "$RESP" = "y" ]; then
  echo "Continuing..."
else
  printf "\nNot deleting. Stopped.\n"
  exit 1
fi

terraform apply .terraform_plan