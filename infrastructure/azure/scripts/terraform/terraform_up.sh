#!/usr/bin/env bash

ENV=$1

if [ $# -eq 0 ]; then
    echo "No arguments provided."
    exit 1
fi

# Where to store the tf.state files - used by the provider block in the terraform code
CORE_RESOURCE_GROUP=core-rg
CORE_STORAGE_ACCOUNT=terraformstatefiles2022
CORE_STORAGE_ACCOUNT_CONATINER_NAME=terraform
CORE_STORAGE_ACCOUNT_KEY=${ENV}/terraform.tfstate

# Where will the applications be deployed? (Information about the AKS cluster and resource group)
RESOURCE_GROUP=${ENV}-rg
CLUSTER_NAME=dac-aks

export KEYS=("ADMIN-GROUP-ID")
KEY_VAULT_NAME=dac-kv

source ./functions/get_current_login.sh
source ./functions/get_subscription_id.sh
source ./functions/get_user_account_id.sh
source ./functions/get_keyvault_secrets.sh
source ./functions/terraform_continue.sh

get_current_login
get_keyvault_secrets $KEY_VAULT_NAME "${KEYS[@]}"

export TF_VAR_subscription=$(get_subscription_id)
export TF_VAR_environment=${ENV}
export TF_VAR_admin_group_object_id=$admin_group_id
export TF_VAR_cluster_name=${CLUSTER_NAME}
export TF_VAR_cluster_rg=${RESOURCE_GROUP}

echo "***Initialising Terraform Azure environment $TF_VAR_environment ..."
cd terraform
terraform init \
	-backend-config="resource_group_name=${CORE_RESOURCE_GROUP}" \
	-backend-config="storage_account_name=${CORE_STORAGE_ACCOUNT}" \
	-backend-config="container_name=${CORE_STORAGE_ACCOUNT_CONATINER_NAME}" \
	-backend-config="key=${CORE_STORAGE_ACCOUNT_KEY}"

echo "***Creating Terraform plan..."
terraform plan --out=.terraform_plan

terraform_continue

echo "***Terraform apply..."
terraform apply .terraform_plan

echo "***Cleaning the local .terraform* files..."
rm -rf .terraform*


echo "***Login Kubectl and Helm to ${TF_VAR_environment}"
az aks get-credentials \
	--resource-group ${RESOURCE_GROUP} \
	--name ${CLUSTER_NAME} \
	--subscription=$TF_VAR_subscription