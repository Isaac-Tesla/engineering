#!/bin/bash


<< COMMENT

   Login for kubectl into the AKS cluster

   Use:
      aks_login <RESOURCE_GROUP> <CLUSTER_NAME>

COMMENT


function aks_login () {

   local RESOURCE_GROUP=$1
   local CLUSTER_NAME=$2

   az aks get-credentials --resource-group $RESOURCE_GROUP --name $CLUSTER_NAME

}