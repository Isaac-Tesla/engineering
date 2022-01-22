#!/usr/bin/env bash

NAMESPACE=mongodb

source ./functions/create_namespace.sh
create_namespace

microk8s helm3 upgrade --install \
    mongodb helm/mongodb/ --namespace $NAMESPACE

microk8s kubectl get services -n $NAMESPACE