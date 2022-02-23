#!/bin/bash


<<COMMENT

   Collects the Service Principal app id for a given Service Principal Name

   Use:
      get_service_principal_app_id  <SERVICE_PRINCIPAL_NAME>

COMMENT


function get_service_principal_app_id () {

   local SERVICE_PRINCIPAL_NAME=$1
   local SERVICE_PRINCIPAL_APP_ID=$(az ad sp list --display-name $SERVICE_PRINCIPAL_NAME --query [0].appId --output tsv)
   echo $SERVICE_PRINCIPAL_APP_ID

}