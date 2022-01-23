#!/usr/bin/env bash

echo "Setup AWS Cli login prior to running this."

export TF_VAR_s3_bucket_for_terraform_state_file="engineering-terraform-state-file"

export TF_VAR_run_if_file_location="file://$HOME/projects/private/aws/terraform/emr/run-if"

echo "Initialising Terraform..."
cd ./terraform/emr_spark
terraform init \
	-backend-config="bucket=${TF_VAR_s3_bucket_for_terraform_state_file}"

terraform plan -out .terraform_plan

read -p "If you continue the displayed plan will be destroyed. Continue? (y/n) " RESP
if [ "$RESP" = "y" ]; then
  echo "Continuing..."
else
  printf "\nStopping now.\n\n\n"
  exit 1
fi

terraform destroy -auto-approve