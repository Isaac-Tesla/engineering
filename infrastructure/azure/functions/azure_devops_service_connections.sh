#!/usr/bin/env bash

ENV=$1
KEY_VAULT=my-azure-kv

echo "Collecting the default subscription id and name..."
export SUBSCRIPTION=$(az account show --query id --output tsv)
export SUBSCRIPTION_NAME=$(az account show --query name --output tsv)

echo "Exporting the Personal Access Token you have already created in Azure DevOps..."
while read line; do export TF_VAR_$line; done < .env

echo "Getting the required info to run the az devops cli commands..."
export TF_VAR_azurerm_spn_tenantid=$(az account tenant list | python3 -c "import sys, json; print(json.load(sys.stdin)[0]['tenantId'])")
export TF_VAR_azuredevops_project_id=$(az devops project show -p EDW --query id --output tsv)
echo "Tenant id = $TF_VAR_azurerm_spn_tenantid "
echo "Project id = $TF_VAR_azuredevops_project_id "
echo "Personal Access Token = $TF_VAR_dev_ops_personal_access_token"

# Azure DevOps Service Endpoints and Azure Service Principals will use the same name.
ENDPOINTS=("endpoint-1" \
           "endpoint-2" \
           "endpoint-3" \
           )

for i in "${ENDPOINTS[@]}"
do
  echo "Endpoint i ==== $i ; Checking if the current service principal exists..."
  export SP_APP_ID=$(az ad sp list --display-name $i | python3 -c "import sys, json; print(json.load(sys.stdin)[0]['appId'])")
  echo "Service principal id = $SP_APP_ID"

  printf "Checking if there is already a matching Service Endpoint in DevOps...\nRetrieving the service endpoint id ..."
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
  export AZURE_DEVOPS_EXT_AZURE_RM_SERVICE_PRINCIPAL_KEY=$(az keyvault secret show --name  ${i}-pwd --vault-name ${KEY_VAULT} --query value --output tsv)

  az devops service-endpoint azurerm create \
    --name $i \
    --azure-rm-tenant-id $TF_VAR_azurerm_spn_tenantid \
    --azure-rm-service-principal-id $SP_APP_ID \
    --azure-rm-subscription-id $SUBSCRIPTION \
    --azure-rm-subscription-name "$SUBSCRIPTION_NAME"

  echo "End process for $i
  "
done