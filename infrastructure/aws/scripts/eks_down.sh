#!/usr/bin/env bash

<<COMMENT

  Summary:
  The following code will use the existing AWS credentials to remove
	an existing EKS cluster/environment using Terraform.

  Note: Setup AWS Cli login prior to running this.

COMMENT


export TF_VAR_s3_bucket_for_terraform_state_file="engineering-terraform-state-file"

cd ./terraform/eks
terraform init \
	-backend-config="bucket=${TF_VAR_s3_bucket_for_terraform_state_file}"

read -p "Running this command will destroy the EKS cluster. Are you sure you want to continue? (y/n) " RESP
if [ "$RESP" = "y" ]; then
  echo "Destroying..."
else
  printf "\nStopping now.\n\n\n"
  exit 1
fi

terraform destroy -auto-approve