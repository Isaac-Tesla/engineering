#!/bin/bash

<<COMMENT

  Summary:
    Retrieves the current subscription name.

  Use:
    SUBSCRIPTION_NAME=$(get_subscription_name)

COMMENT


function get_subscription_name () {
      
   local SUBSCRIPTION_NAME=$(az account show --query name --output tsv)
   echo $SUBSCRIPTION_NAME

}