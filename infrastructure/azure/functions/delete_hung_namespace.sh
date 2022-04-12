#! /bin/bash


<<COMMENT

   Summary:
      Deletes a namespace when stuck in a "terminating" state.

   Use:
      delete_hung_namespace  <NAMESPACE> 

COMMENT


function delete_hung_namespace () {

    local NAMESPACE=$1

    kubectl get namespace "${NAMESPACE}" -o json \
    | tr -d "\n" | sed "s/\"finalizers\": \[[^]]\+\]/\"finalizers\": []/" \
    | kubectl replace --raw /api/v1/namespaces/${NAMESPACE}/finalize -f -

}