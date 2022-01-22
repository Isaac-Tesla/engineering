#!/usr/bin/env bash

export NAMESPACE=kafka

microk8s helm3 uninstall kafka --namespace $NAMESPACE