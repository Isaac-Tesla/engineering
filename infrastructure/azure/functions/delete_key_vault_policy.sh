#!/bin/bash


<<COMMENT

   Summary:
      Removes Service Principal access from a key vault specified.

   Use:
      delete_key_vault_policy  <KEY_VAULT_NAME>  <SERVICE_PRINCIPAL_OBJECT_ID>

COMMENT


function delete_key_vault_policy () {

   local KEY_VAULT_NAME=$1
   local SERVICE_PRINCIPAL_OBJECT_ID=$2

   az keyvault delete-policy --name $KEY_VAULT_NAME --object-id $SERVICE_PRINCIPAL_OBJECT_ID

}
