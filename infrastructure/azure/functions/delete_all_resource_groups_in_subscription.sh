#!/bin/bash


<<COMMENT

   Summary:
      Removes all resource groups and contents of those resource 
      groups within a specified subscription.

   Note: Check the current subscription you are logged into prior
      to running this code.

   Use:
      delete_all_resource_groups_in_subscription <SUBSCRIPTION>

COMMENT


function delete_all_resource_groups_in_subscription () {

   RESOURCE_GROUP_ARRAY=($(az group list --query [].name --output tsv))

   for i in "${RESOURCE_GROUP_ARRAY[@]}"
   do
      az group delete --yes -y -n $i 
   done

}