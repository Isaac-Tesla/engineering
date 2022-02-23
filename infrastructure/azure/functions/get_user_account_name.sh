#!/bin/bash

<<COMMENT

  Summary:
    Retrieves the current user account name.

  Use:
    USER_ACCOUNT_NAME=$(get_user_account_name)

COMMENT


function get_user_account_name () {
      
   local USER_ACCOUNT_NAME=$(az ad signed-in-user show --query displayName --output tsv)
   echo $USER_ACCOUNT_NAME

}