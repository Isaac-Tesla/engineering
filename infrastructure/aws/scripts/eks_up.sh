#!/usr/bin/env bash

<<COMMENT

  Summary:
  The following code will use the existing AWS credentials to add
	  an EKS cluster/environment using Terraform. The metrics server 
    and the dashboard will also be created, with the dashboard 
    token required to be saved.

  Note: Setup AWS Cli login prior to running this. 

  To fix: Save the dashboard token to AWS Secrets Manager.

COMMENT


export TF_VAR_s3_bucket_for_terraform_state_file="engineering-terraform-state-file"

cd ./terraform/eks
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

# Get the credentials
aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)

# Deploy the metrics server
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
kubectl get deployment metrics-server -n kube-system

# Setup the dashboards' extra requirements
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.4.0/aio/deploy/recommended.yaml
kubectl apply -f ./terraform/eks/kubernetes-dashboard-admin.rbac.yaml