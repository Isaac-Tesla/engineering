#!/bin/bash


<<COMMENT

   Collects the secret from a set key vault.

   Use:
      get_key_vault_secret  <SECRET_NAME>  <KEY_VAULT_NAME>

COMMENT


function get_key_vault_secret () {

   local SECRET_NAME=$1
   local KEY_VAULT_NAME=$2
   local SECRET=$(az keyvault secret show --name $SECRET_NAME --vault-name $KEY_VAULT_NAME --query value --output tsv)
   echo $SECRET

}