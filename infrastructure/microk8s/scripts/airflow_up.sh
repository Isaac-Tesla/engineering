#!/usr/bin/env bash

NAMESPACE=airflow
HELM_CHART_NAME=airflow
HELM_CHART_LOCATION=helm/airflow/
PWD=$(pwd)
HOSTNAME_LONG=$(microk8s kubectl get nodes -o name)
HOSTNAME=$(echo $HOSTNAME_LONG | sed 's/node\//''/')
MNT_LOCATION=/tmp/dags

source ./functions/create_namespace.sh
create_namespace

mkdir ./tmp/dags
cp -r ./pipes/dags/* .$MNT_LOCATION

microk8s helm3 upgrade --install \
    --set configmap.core.sql_alchemy_conn="postgresql://pgusr:pgpwd@postgres-svc.airflow.svc.cluster.local:5432/airflow" \
    --set airflow.webserver.adminUser.user="airflow" \
    --set airflow.webserver.adminUser.password="airflow" \
    --set postgresql.credentials.user="pgusr" \
    --set postgresql.credentials.password="pgpwd" \
    --set airflow.storage.mnt="${PWD}${MNT_LOCATION}" \
    --set microk8s.nodeAffinity=$HOSTNAME \
    $HELM_CHART_NAME $HELM_CHART_LOCATION --namespace $NAMESPACE

microk8s kubectl get services -n $NAMESPACE