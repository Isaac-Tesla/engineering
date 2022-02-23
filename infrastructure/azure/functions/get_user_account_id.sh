#!/bin/bash

<<COMMENT

  Summary:
    Retrieves the current user account id.

  Use:
    USER_ACCOUNT_ID=$(get_user_account_id)

COMMENT


function get_user_account_id () {
      
   local USER_ACCOUNT_ID=$(az ad signed-in-user show --query objectId --output tsv)
   echo $USER_ACCOUNT_ID

}