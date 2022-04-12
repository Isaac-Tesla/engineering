#!/bin/bash

<<COMMENT

   Summary:
      Uses a set storage type to provision in AKS.

   Use:
      create_storage_class  \
         <AKS_SECRET_NAME>  \
         <NAMESPACE>  \
         <STORAGE_TYPE>  \
         <STORAGE_NAME>  \
         <STORAGE_YAML_LOCATION>  \
         <AZURE_STORAGE_NAME>  \
         <AZURE_RESOURCE_GROUP>

COMMENT


function enforce_storage () {

   local AKS_SECRET_NAME=$1
   local NAMESPACE=$2
   local STORAGE_TYPE=$3
   local STORAGE_NAME=$4
   local STORAGE_YAML_LOCATION=$5
   local AZURE_STORAGE_NAME=$6
   local AZURE_RESOURCE_GROUP=$7
   
   local STORAGE_EXISTS=$(kubectl get $STORAGE_TYPE $STORAGE_NAME \
                           -namespace $NAMESPACE \
                           --ignore-not-found);

   if [[ "$STORAGE_EXISTS" ]]; then
      echo "Skipping creation of $STORAGE_TYPE $STORAGE_NAME, it already exists";
   else
      echo "Creating $STORAGE_TYPE $STORAGE_NAME";
      AKS_SECRET_NAME=$AKS_SECRET_NAME \
         SECRET_NAMESPACE=$NAMESPACE \
         AZURE_RESOURCE_GROUP=$AZURE_RESOURCE_GROUP \
         AZURE_STORAGE_NAME=$AZURE_STORAGE_NAME \
         AKS_SECRET_NAME=$AKS_SECRET_NAME \
         envsubst < $STORAGE_YAML_LOCATION | kubectl apply -n $NAMESPACE -f -
   fi;

}