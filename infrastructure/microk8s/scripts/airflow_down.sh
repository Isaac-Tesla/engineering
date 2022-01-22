#!/usr/bin/env bash

export NAMESPACE=airflow
export HELM_CHART_NAME=airflow

microk8s helm3 uninstall $HELM_CHART_NAME --namespace $NAMESPACE

rm -rf ./tmp/dags