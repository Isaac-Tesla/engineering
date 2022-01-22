#!/usr/bin/env bash

export NAMESPACE=metabase

microk8s helm3 uninstall metabase --namespace $NAMESPACE