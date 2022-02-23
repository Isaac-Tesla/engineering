#!/bin/bash


<<COMMENT

   Collects the Service Principal object id for a given Service Principal Name

   Use:
      get_service_principal_object_id  <SERVICE_PRINCIPAL_NAME>

COMMENT


function get_service_principal_object_id () {

   local SERVICE_PRINCIPAL_NAME=$1
   local SERVICE_PRINCIPAL_OBJECT_ID=$(az ad sp list --display-name $SERVICE_PRINCIPAL_NAME --query [0].objectId --output tsv)
   echo $SERVICE_PRINCIPAL_OBJECT_ID

}