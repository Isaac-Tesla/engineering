#!/usr/bin/env bash

export NAMESPACE=superset

microk8s helm3 uninstall superset --namespace $NAMESPACE