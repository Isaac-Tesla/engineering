#!/usr/bin/env bash

NAMESPACE=nifi

helm upgrade --install \
    nifi applications/helm/nifi/ --namespace $NAMESPACE
