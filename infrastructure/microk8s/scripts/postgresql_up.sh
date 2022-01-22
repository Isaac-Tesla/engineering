#!/usr/bin/env bash

NAMESPACE=postgres

source ./functions/create_namespace.sh
create_namespace

microk8s helm3 upgrade --install \
    --set postgres.credentials.user="postgres" \
    --set postgres.credentials.password="postgres" \
    --set pgadmin.credentials.user="postgres@test.com" \
    --set pgadmin.credentials.password="postgres" \
    postgres helm/postgresql --namespace $NAMESPACE

microk8s kubectl get services -n $NAMESPACE