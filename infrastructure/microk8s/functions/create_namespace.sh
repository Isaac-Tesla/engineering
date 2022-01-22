#!/bin/bash

create_namespace () {

   echo "Checking $NAMESPACE Namespace ..."

   NS=$($COMMAND kubectl get namespace $NAMESPACE --ignore-not-found);
   if [[ "$NS" ]]; then
      echo "Skipping creation of namespace $NAMESPACE - already exists";
   else
      echo "Creating namespace $NAMESPACE";
      $COMMAND kubectl create namespace $NAMESPACE;
   fi;

}