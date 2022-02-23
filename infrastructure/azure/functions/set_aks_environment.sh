#!/bin/bash

<< COMMENT

   Sets Kubectl to the current environment.

   Use:
      set_aks_environment <ENV>

COMMENT


function set_aks_environment () {

   local CLUSTER_NAME=$1
   kubectl config use-context ${CLUSTER_NAME}

}