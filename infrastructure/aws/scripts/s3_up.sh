#!/usr/bin/env bash

# Cloudformation method
# aws cloudformation deploy \
#     --template-file ./cloudformation/s3.yaml \
#     --stack-name s3-bucket


# Terraform

# Remember prior to running this to ensure the Terraform State file bucket has been created -> TF_VAR_s3_bucket_for_terraform_state_file= ?

export TF_VAR_s3_bucket_for_terraform_state_file="engineering-terraform-state-file"

cd ./terraform/s3
terraform init \
	-backend-config="bucket=${TF_VAR_s3_bucket_for_terraform_state_file}" \
    -backend-config="key=statefile/s3/terraform.tfstate" \
    -backend-config="region=ap-southeast-2"

terraform plan -out .terraform_plan

read -p "Are you sure you want to continue with this Terraform plan? (y/n) " RESP
if [ "$RESP" = "y" ]; then
  echo "Continuing..."
else
  printf "\nStopping now.\n\n\n"
  exit 1
fi

terraform apply .terraform_plan