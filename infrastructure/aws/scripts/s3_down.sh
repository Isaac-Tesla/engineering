#!/usr/bin/env bash

# Cloudformation method
# aws cloudformation delete-stack --stack-name s3-bucket


export TF_VAR_s3_bucket_for_terraform_state_file="engineering-terraform-state-file"

cd ./terraform/s3
terraform init \
	-backend-config="bucket=${TF_VAR_s3_bucket_for_terraform_state_file}" \
    -backend-config="key=statefile/s3/terraform.tfstate" \
    -backend-config="region=ap-southeast-2"

terraform plan -destroy -out .terraform_plan

read -p "If you continue the displayed plan will be removed. Continue? (y/n) " RESP
if [ "$RESP" = "y" ]; then
  echo "Continuing..."
else
  printf "\nStopping now.\n\n\n"
  exit 1
fi

terraform destroy -auto-approve