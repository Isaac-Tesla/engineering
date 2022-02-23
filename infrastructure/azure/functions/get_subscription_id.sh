#!/bin/bash

<<COMMENT

  Summary:
    Retrieves the current subscription id.

  Use:
    SUBSCRIPTION_ID=$(get_subscription_id)

COMMENT


function get_subscription_id () {
      
   local SUBSCRIPTION_ID=$(az account show --query id --output tsv)
   echo $SUBSCRIPTION_ID

}