#!/usr/bin/env bash

NAMESPACE=superset

source ./functions/create_namespace.sh
create_namespace

helm repo add superset https://apache.github.io/superset

microk8s helm3 upgrade --install \
    superset superset/superset --namespace $NAMESPACE

microk8s kubectl get services -n $NAMESPACE