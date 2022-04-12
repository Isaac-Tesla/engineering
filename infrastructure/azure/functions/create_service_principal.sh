#!/bin/bash


<<COMMENT

   Summary:
      Creates a Service Principal with the current Tenant 
         as the owner, adds information to key vault.

   Use:
      create_service_principal  <SERVICE_PRINCIPAL_NAME>  <KEY_VAULT_NAME>  <AZURE_CONTAINER_REGISTRY_NAME>

COMMENT


source ./functions/get_service_principal_tenant_id.sh
source ./functions/get_subscription_id.sh


function create_service_principal () {

   local SERVICE_PRINCIPAL_NAME=$1
   local KEY_VAULT_NAME=$2
   local AZURE_CONTAINER_REGISTRY_NAME=$3
   local SUBSCRIPTION_ID=$(get_subscription_id)
   local AZURE_CONTAINER_REGISTRY_ID=$(az acr show --name $AZURE_CONTAINER_REGISTRY_NAME --query id --output tsv --subscription $SUBSCRIPTION_ID)
   local SERVICE_PRINCIPAL_PASSWORD=$(az ad sp create-for-rbac --name $SERVICE_PRINCIPAL_NAME --scopes $AZURE_CONTAINER_REGISTRY_ID --role AcrPull --query password --output tsv)
   local TENANT_ID=$(get_service_principal_tenant_id  $SERVICE_PRINCIPAL_NAME)

   az keyvault secret set --name $SERVICE_PRINCIPAL_NAME-password --vault-name $KEY_VAULT_NAME --value $SERVICE_PRINCIPAL_PASSWORD --output none
   az keyvault secret set --name $SERVICE_PRINCIPAL_NAME-tenantId --vault-name $KEY_VAULT_NAME --value $TENANT_ID --output none 

}