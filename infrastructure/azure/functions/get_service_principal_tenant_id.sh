#!/bin/bash


<<COMMENT

   Collects the Service Principal tenant id for a given Service Principal Name

   Use:
      get_service_principal_tenant_id  <SERVICE_PRINCIPAL_NAME>

COMMENT


function get_service_principal_tenant_id () {

   local SERVICE_PRINCIPAL_NAME=$1
   local SERVICE_PRINCIPAL_TENANT_ID=$(az ad sp list --display-name $SERVICE_PRINCIPAL_NAME --query [0].appOwnerTenantId --output tsv)
   echo $SERVICE_PRINCIPAL_TENANT_ID

}