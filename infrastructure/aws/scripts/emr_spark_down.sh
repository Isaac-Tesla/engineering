#!/usr/bin/env bash

<<COMMENT

  Summary:
  The following code will use the existing AWS credentials to delete
	an EMR cluster using Terraform.

COMMENT


source ./functions/terraform_continue.sh

export TF_VAR_s3_bucket_for_terraform_state_file="engineering-terraform-state-file"
export TF_VAR_run_if_file_location="file://$HOME/projects/private/aws/terraform/emr/run-if"

cd ./terraform/emr_spark
terraform init \
	-backend-config="bucket=${TF_VAR_s3_bucket_for_terraform_state_file}"

terraform plan -out .terraform_plan
terraform_continue
terraform destroy -auto-approve