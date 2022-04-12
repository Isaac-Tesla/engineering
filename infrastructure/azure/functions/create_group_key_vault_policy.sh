#! /bin/bash


<<COMMENT

   Summary:
      Create a key vault policy for a group, given the 
        group name in Active Directory.

   Use:
      create_key_vault_policy  <GROUP_NAME>  <KEY_VAULT>

COMMENT


function create_key_vault_policy () {

    local GROUP_NAME=$1
    local KEY_VAULT=$2
    local GROUP_ID=$(az ad group list --display-name ${GROUP_NAME} --query [].objectId --output tsv)

    az keyvault set-policy --name $KEY_VAULT --object-id ${GROUP_ID} \
        --secret-permissions {get,list,delete,recover,set} \
        --key-permissions {create,decrypt,delete,encrypt,get,import,list,recover,restore,sign,update,verify} \
        --certificate-permissions {get,list,update,create,import,delete,recover,backup,restore}

}