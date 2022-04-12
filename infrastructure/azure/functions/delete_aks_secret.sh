#!/bin/bash


<<COMMENT

   Summary:
      Delete a secret from AKS namespace.

   Use:
      delete_aks_secret  <AKS_SECRET_NAME>  <NAMESPACE>

COMMENT


function delete_aks_secret () {

   local AKS_SECRET_NAME=$1
   local NAMESPACE=$2
   local SECRET_EXISTS=$(kubectl get secret --namespace $NAMESPACE $AKS_SECRET_NAME --ignore-not-found);

   if [[ "$SECRET_EXISTS" ]]; then
     echo "Cleaning out current AKS secret $AKS_SECRET_NAME from namespace";
     kubectl delete secret --namespace $NAMESPACE $AKS_SECRET_NAME;
   else
      echo "Cannot delete as no AKS secret $AKS_SECRET_NAME exists yet.";
   fi;

}