#!/bin/bash


<<COMMENT

   Summary:
      Builds a Dockerfile image from a set location and 
         pushes to a specified container registry.

   Use:
      create_and_push_image_to_container_registry  <DOCKERFILE_LOCATION>  <AZURE_CONTAINER_REGISTRY_NAME>  <IMAGE_NAME>  <IMAGE_TAG>

   Example:
      create_and_push_image_to_container_registry  applications/docker/airflow  mycr  apache/airflow  2.2.3

COMMENT


function create_and_push_image_to_container_registry () {

   local DOCKERFILE_LOCATION=$1
   local AZURE_CONTAINER_REGISTRY_NAME=$2
   local IMAGE_NAME=$3
   local IMAGE_TAG=$4
   local CHECK_IN_REGISTRY=$(az acr repository show --name $AZURE_CONTAINER_REGISTRY_NAME --image $IMAGE_NAME:$IMAGE_TAG --query name --output tsv)
   
   if [[ $CHECK_IN_REGISTRY == $IMAGE_TAG ]]; then
      echo "Skipping creation of image $IMAGE_NAME:$IMAGE_TAG, already exists in container registry $AZURE_CONTAINER_REGISTRY_NAME";
   else
      echo "Build $IMAGE_NAME and push to container registry $AZURE_CONTAINER_REGISTRY_NAME";
      cd $DOCKERFILE_LOCATION && docker build -t $IMAGE_NAME:$IMAGE_TAG .
      cd ../../..
      az acr login --name $AZURE_CONTAINER_REGISTRY_NAME.azurecr.io
      docker tag $IMAGE_NAME:$IMAGE_TAG $AZURE_CONTAINER_REGISTRY_NAME.azurecr.io/$IMAGE_NAME:$IMAGE_TAG
      docker push $AZURE_CONTAINER_REGISTRY_NAME.azurecr.io/$IMAGE_NAME:$IMAGE_TAG
   fi;
   
}