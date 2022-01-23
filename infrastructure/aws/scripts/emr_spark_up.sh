#!/usr/bin/env bash

<<COMMENT

  Summary:
  The following code will use the existing AWS credentials to add
	  an EMR cluster using Terraform. An EMR cluster setup 
	  typically takes 7-10 minutes to provision.

  Note: Setup AWS Cli login prior to running this. 

  To fix: 
  The current setup is messy due to a bootstrapping issue.
	1. s3 bucket is terraformed (so it is in the state file)
	2. the run-if file is copied across
	3. EMR is terraformed (using the same state file / s3 bucket 
		so it can access the run-if file)

COMMENT


export TF_VAR_s3_bucket_for_terraform_state_file="engineering-terraform-state-file"
export TF_VAR_run_if_file_location="file://$HOME/projects/private/aws/terraform/emr/run-if"

cd ./terraform/emr_spark
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