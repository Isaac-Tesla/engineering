#!/bin/bash

<<COMMENT

   Summary:
   Creates a AKS secret in a set namespace for csi-blob 
      driver to be able to access blobs in Azure Storage.

   Use:
      create_aks_blob_secret <NAMESPACE> <STORAGE_ACCOUNT> <AKS_SECRET> <RESOURCE_GROUP>

COMMENT


function create_aks_blob_secret () {

   local NAMESPACE=$1
   local STORAGE_ACCOUNT=$2
   local AKS_SECRET=$3
   local RESOURCE_GROUP=$4

   local EXISTS=$(kubectl get secret --namespace $NAMESPACE $AKS_SECRET --ignore-not-found);

   if [[ "$EXISTS" ]]; then
      echo "Secret already exists, skipping creation."
   else
      local SUBSCRIPTION_ID=$(get_subscription_id)

      echo "Creating secret in $NAMESPACE namespace."
      local STORAGE_ACCOUNT_KEY=$(az storage account keys list \
                        --account-name $STORAGE_ACCOUNT \
                        --resource-group $RESOURCE_GROUP \
                        --subscription $SUBSCRIPTION_ID \
                        --query [0].value \
                        --output tsv)
                        
      kubectl create secret generic $AKS_SECRET \
      --namespace $NAMESPACE \
      --from-literal=azurestorageaccountname=$STORAGE_ACCOUNT \
      --from-literal=azurestorageaccountkey=$STORAGE_ACCOUNT_KEY
   fi;

}