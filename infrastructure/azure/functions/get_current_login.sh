#!/bin/bash


<<COMMENT

   Checks with the user the current logged-in profile.

   Use:
      get_current_login

COMMENT


source ./functions/get_user_account_name.sh
source ./functions/get_subscription_name.sh

function get_current_login () {

   local SUBSCRIPTION_NAME=$(get_subscription_name)
   local USER_ACCOUNT=$(get_user_account_name)

   printf "\n\nCurrent subscription ==>   $SUBSCRIPTION_NAME \nCurrent user ==> $USER_ACCOUNT\n"
   read -p "Is this correct? (y/n) " RESP

   if [ "$RESP" = "y" ]; then
    echo "Continuing with subscription $SUBSCRIPTION_NAME"
   else
      printf "\nExiting. Please set your default subscription.\nTo list your subscription options use: az account list -o table\n\nTo set your default subscription use: az account set --subscription <subscriptionId>\n\n\n"
      exit 1
   fi

}