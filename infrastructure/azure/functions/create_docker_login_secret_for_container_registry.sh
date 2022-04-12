#!/bin/bash


<<COMMENT

   Summary:
      Creates an AKS Docker secret to enable access 
         to a container registry through a namespace.

   Use:
      create_docker_login_secret_for_container_registry  \
         <NAMESPACE>  \
         <SECRET_NAME>  \
         <SERVICE_PRINCIPAL_APP_ID>  \
         <SERVICE_PRINCIPAL_PASSWORD>  \
         <AZURE_CONTAINER_REGISTRY_NAME>


COMMENT


function create_docker_login_secret_for_container_registry () {

   local NAMESPACE=$1
   local SECRET_NAME=$2
   local SERVICE_PRINCIPAL_APP_ID=$3
   local SERVICE_PRINCIPAL_PASSWORD=$4
   local AZURE_CONTAINER_REGISTRY_NAME=$5 
   local SECRET_EXISTS=$(kubectl get secret --namespace $NAMESPACE $SECRET_NAME --ignore-not-found);

   if [[ "$SECRET_EXISTS" ]]; then
      echo "Secret already exists, skipping creation."
   else
      echo "Creating AKS secret in $NAMESPACE namespace for accessing the container registry."
      docker login \
         --username=$SERVICE_PRINCIPAL_APP_ID \
         --password=$SERVICE_PRINCIPAL_PASSWORD \
         $AZURE_CONTAINER_REGISTRY_NAME.azurecr.io
      
      echo "Using the docker login credentials to build the secret in the namespace."
      kubectl create secret docker-registry $SECRET_NAME \
         --namespace $NAMESPACE \
         --docker-server=$AZURE_CONTAINER_REGISTRY_NAME.azurecr.io \
         --docker-username=$SERVICE_PRINCIPAL_APP_ID \
         --docker-password=$SERVICE_PRINCIPAL_PASSWORD
   fi;

}