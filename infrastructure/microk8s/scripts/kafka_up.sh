#!/usr/bin/env bash

NAMESPACE=kafka

source ./functions/create_namespace.sh
create_namespace

microk8s helm3 upgrade --install \
    kafka helm/kafka/ --namespace $NAMESPACE

microk8s kubectl get services -n $NAMESPACE