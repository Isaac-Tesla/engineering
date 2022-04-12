#!/bin/bash


<<COMMENT

   Summary:
      Removes a specified Service Principal

   Use:
      delete_service_principal  <SERVICE_PRINCIPAL_NAME>

COMMENT


function delete_service_principal () {

   local SERVICE_PRINCIPAL_NAME=$1

   APP_ID=$(az ad app list --display-name $SERVICE_PRINCIPAL_NAME --query [].objectId --output tsv)
   SP_APP_ID=$(az ad sp list --display-name $SERVICE_PRINCIPAL_NAME --query [0].appId --output tsv)

   az ad sp delete --id $SP_APP_ID
   az ad app delete --id $APP_ID

}