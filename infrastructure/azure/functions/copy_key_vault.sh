#!/bin/bash

<<COMMENT

  Summary:
    Copies all secrets from one specified key vault 
    to another specified key vault.

  Use:
    copy_key_vault  <KEY_VAULT_SOURCE>  <KEY_VAULT_DESTINATION>

COMMENT


function copy_key_vault () {

    local KEY_VAULT_SOURCE=$1
    local KEY_VAULT_DESTINATION=$2
    local KEY_VAULT_SOURCE_KEYS_LIST=$(az keyvault secret list --vault-name $KEY_VAULT_SOURCE --query [].name)

    KEY_LIST=$(echo ${KEY_VAULT_SOURCE_KEYS_LIST//,/ } | tr -d '[]"')
    arrIN=(${KEY_LIST// / })

    for i in "${arrIN[@]}"
    do
        echo $i
        local SECRET_VALUE=$(az keyvault secret show --name $i --vault-name ${KEY_VAULT_SOURCE} --query value --output tsv)
        az keyvault secret set --vault-name $KEY_VAULT_DESTINATION --name $i --value $SECRET_VALUE
    done

}