#!/usr/bin/env bash

# Cloudformation method
# aws cloudformation delete-stack --stack-name s3-bucket

# Terraform
read -p "Running this command will destroy the s3 bucket. Are you sure you want to continue? (y/n) " RESP
if [ "$RESP" = "y" ]; then
  echo "Destroying!"
else
  printf "\nStopping now.\n\n\n"
  exit 1
fi

export AWS_ACCESS_KEY_ID=$(KEY=$(cat $HOME/.aws/credentials | grep aws_access_key_id); read -ra arr <<<"$KEY"; echo ${arr[2]})
export AWS_SECRET_ACCESS_KEY=$(KEY=$(cat $HOME/.aws/credentials | grep secret_access_key); read -ra arr <<<"$KEY"; echo ${arr[2]})
export TF_VAR_s3_bucket_for_terraform_state_file="s3-bucket-for-terraform-state-file"

cd ./terraform/s3
terraform init \
	-backend-config="bucket=${TF_VAR_s3_bucket_for_terraform_state_file}" \
    -backend-config="key=statefile/s3/terraform.tfstate" \
    -backend-config="region=ap-southeast-2"

terraform destroy -auto-approve