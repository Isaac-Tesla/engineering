#!/usr/bin/env bash

<<COMMENT

  Summary:
  The following code will use the existing AWS credentials to delete
	an ELK stack using Terraform.

  Note: Setup AWS Cli login prior to running this.

COMMENT


source ./functions/terraform_continue.sh

export TF_VAR_s3_bucket_for_terraform_state_file="engineering-terraform-state-file"

echo "Initialising Terraform..."
cd ./terraform/elasticache
terraform init \
	-backend-config="bucket=${TF_VAR_s3_bucket_for_terraform_state_file}"

terraform plan -out .terraform_plan
terraform_continue
terraform destroy -auto-approve