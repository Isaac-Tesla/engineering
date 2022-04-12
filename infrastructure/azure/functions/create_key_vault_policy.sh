#!/bin/bash


<<COMMENT

   Summary:
      Creates a key vault policy for a service principal.

   Use:
      create_key_vault_policy  <KEY_VAULT_NAME>  <SERVICE_PRINCIPAL_OBJECT_ID>

COMMENT


function create_key_vault_policy () {

   local KEY_VAULT_NAME=$1
   local SERVICE_PRINCIPAL_OBJECT_ID=$2

   az keyvault set-policy --name $KEY_VAULT_NAME --secret-permissions get list --object-id $SERVICE_PRINCIPAL_OBJECT_ID --output none
   printf "Policy set for Service Principal to access key vault $KEY_VAULT_NAME\n"
   
}