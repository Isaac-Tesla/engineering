#!/usr/bin/env bash

echo "Setup AWS Cli login prior to running this."
echo "EMR cluster setup typically takes 7 minutes to provision."

# The current setup is messy due to a bootstrapping issue. -- FIX!
# 1. s3 bucket is terraformed (so it is in the state file)
# 2. the run-if file is copied across
# 3. EMR is terraformed (using the same state file / s3 bucket so it can access the run-if file)

export TF_VAR_s3_bucket_for_terraform_state_file="engineering-terraform-state-file"

export TF_VAR_run_if_file_location="file://$HOME/projects/private/aws/terraform/emr/run-if"

echo "Initialising Terraform..."
cd ./terraform/emr_spark
terraform init \
	-backend-config="bucket=${TF_VAR_s3_bucket_for_terraform_state_file}"

terraform plan -out .terraform_plan

terraform apply .terraform_plan