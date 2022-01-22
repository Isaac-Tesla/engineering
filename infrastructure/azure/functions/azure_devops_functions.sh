#!/bin/bash


ENV=$1
KEY_VAULT=my-azure-kv


export SUBSCRIPTION=$(az account show --query id --output tsv)
export SUBSCRIPTION_NAME=$(az account show --query name --output tsv)
export TENANT_ID=$(az account tenant list --query [].tenantId --output tsv)
export AZURE_DEVOPS_PROJECT_ID=$(az devops project show -p EDW --query id --output tsv)
export USER_ACCOUNT=$(az ad signed-in-user show --query displayName --output tsv)


printf "\n\nUsing your default subscription ==>   $SUBSCRIPTION_NAME \n\nCurrent user is ==> $USER_ACCOUNT\n\n"
read -p "Is this correct? (y/n) " RESP
if [ "$RESP" = "y" ]; then
  echo "Continuing with subscription $SUBSCRIPTION_NAME"
else
  printf "\nExiting. Please set your default subscription.\n\nTo list your subscription options use: az account list -o table\n\nTo set your default subscription use: az account set --subscription <subscriptionId>\n\n\n"
  exit 1
fi


echo "Exporting the Personal Access Token you have already created in Azure DevOps..."
while read line; do export $line; done < personal_access_token.env


create_service_endpoint_from_service_principal () {

   # A Service Endpoint in Azure DevOps requires a Service Principal
   #   in Azure. This function creates a new Service Endpoint in 
   #   Azure DevOps with a matching name and links it to an existing 
   #   Service Principal in Azure. 

   printf "\n\nStarting create_service_endpoint_from_service_principal.\n"
   local SERVICE_PRINCIPAL_NAME=$2
   local SERVICE_PRINCIPAL_ID=$(az ad sp list --display-name $SERVICE_PRINCIPAL_NAME --query [].appId --output tsv)

   echo "Checking if there is already a matching Service Endpoint in DevOps..."
   echo "Retrieving the service endpoint id ..."
   export ENDPOINT_ID=$(az devops service-endpoint list | python3 -c "import sys, json, pandas as pd; df = pd.DataFrame(json.load(sys.stdin)); print( df.loc[df['name'] == '$i', 'id'].item() )")

   if [[ "$ENDPOINT_ID" ]]; then
      echo "Service endpoint id = $ENDPOINT_ID";
      echo "Removing old Service Endpoint and creating new one..."
      az devops service-endpoint delete \
         --id $ENDPOINT_ID \
         -y   
   else
      echo "No Service endpoint exists, creating";
   fi;

   echo "Creating a new Service Endpoint, pulling the Service Principal password from the key vault."
   export AZURE_DEVOPS_EXT_AZURE_RM_SERVICE_PRINCIPAL_KEY=$(az keyvault secret show --name  ${SERVICE_PRINCIPAL_NAME}-pwd --vault-name ${KEY_VAULT} --query value --output tsv)

   az devops service-endpoint azurerm create \
      --name $SERVICE_PRINCIPAL_NAME \
      --azure-rm-tenant-id $TENANT_ID \
      --azure-rm-service-principal-id $SERVICE_PRINCIPAL_ID \
      --azure-rm-subscription-id $SUBSCRIPTION \
      --azure-rm-subscription-name "$SUBSCRIPTION_NAME"
}