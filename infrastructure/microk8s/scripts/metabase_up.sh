#!/usr/bin/env bash

NAMESPACE=metabase

source ./functions/create_namespace.sh
create_namespace

microk8s helm3 upgrade --install \
    metabase helm/metabase/ --namespace $NAMESPACE

microk8s kubectl get services -n $NAMESPACE