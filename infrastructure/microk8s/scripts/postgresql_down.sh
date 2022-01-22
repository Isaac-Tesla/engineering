#!/usr/bin/env bash

export NAMESPACE=postgres

microk8s helm3 uninstall postgres --namespace $NAMESPACE