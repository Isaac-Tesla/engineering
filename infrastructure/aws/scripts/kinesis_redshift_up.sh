#!/usr/bin/env bash

<<COMMENT

  Summary:
  The following code will use the existing AWS credentials to add
	  Redshift using Terraform.

COMMENT


source ./functions/terraform_continue.sh

export TF_VAR_s3_bucket_for_terraform_state_file="engineering-terraform-state-file"

cd ./terraform/kinesis_redshift
terraform init \
	-backend-config="bucket=${TF_VAR_s3_bucket_for_terraform_state_file}"

terraform plan -out .terraform_plan
terraform_continue
terraform apply .terraform_plan