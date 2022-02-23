#!/bin/bash


<<COMMENT

   Collects the key vault secrets as envrionment variables, 
      referenced in lowercase with underscore.
      e.g. SOME-PASSWORD -> some_password

   Use:
      get_key_vault_secrets  <KEY_VAULT_NAME>  <exported KEYS>

   Example: 
      export KEYS=("KEY-VAULT-SECRET-1" \
          "KEY-VAULT-SECRET-2" \
          "KEY-VAULT-SECRET-3" \
          "KEY-VAULT-SECRET-4" \
      )
      get_keyvault_secrets  key-vault-name

COMMENT


function get_key_vault_secrets () {

   local KEY_VAULT_NAME=$1
   shift
   local KEYS=("$@")

   for i in "${KEYS[@]}"
   do
      export "$(echo ${i//-/_} | tr '[A-Z]' '[a-z]')"=$(az keyvault secret show --name $i --vault-name $KEY_VAULT_NAME --query value --output tsv)
   done

}