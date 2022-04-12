#! /bin/bash


<<COMMENT

   Summary:
      Removes apps that have been orphaned. User removing must
        have correct access level for this.

   Use:
      delete_orphaned_apps  <ORPHANED_APPS>

   Example:
      export ORPHANED_APPS=("app1-sp" \
            "app2-sp" \
            "app3-sp"
      )
      delete_orphaned_apps $ORPHANED_APPS

COMMENT


source ./functions/get_user_account_id.sh


function delete_orphaned_apps () {

  local ORPHANED_APPS=$1
  local CURRENT_USER_ID=$(get_user_account_id)

  for i in "${ORPHANED_APPS[@]}"
  do
    APP_ID=$(az ad app list --display-name $i --query [].objectId --output tsv)
    echo $i $APP_ID
    az ad app owner add --id $APP_ID --owner-object-id $CURRENT_USER_ID
    az ad app delete --id $APP_ID
  done

}