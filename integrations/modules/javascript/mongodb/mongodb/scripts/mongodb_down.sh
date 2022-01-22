#!/usr/bin/env bash

export NAMESPACE=mongodb

microk8s helm3 uninstall mongodb --namespace $NAMESPACE