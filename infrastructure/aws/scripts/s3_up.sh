#!/usr/bin/env bash

<<COMMENT

  Summary:
  The following code will use the existing AWS credentials to add
	  an S3 bucket using Terraform.

  Note:
  A Cloudformation template also exists for this, to use instead,
    run:

      aws cloudformation deploy \
       --template-file ./cloudformation/s3.yaml \
       --stack-name s3-bucket

COMMENT


source ./functions/terraform_continue.sh

export TF_VAR_s3_bucket_for_terraform_state_file="engineering-terraform-state-file"

cd ./terraform/s3
terraform init \
	-backend-config="bucket=${TF_VAR_s3_bucket_for_terraform_state_file}" \
    -backend-config="key=statefile/s3/terraform.tfstate" \
    -backend-config="region=ap-southeast-2"

terraform plan -out .terraform_plan
terraform_continue
terraform apply .terraform_plan