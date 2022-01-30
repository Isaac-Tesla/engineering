#!/usr/bin/env bash

# Now, use your installed client to push instructions
#   to the kubernetes cluster which will spin up what
#   it needs.

# COMMAND EXAMPLE:
# microk8s kubectl cluster-info
# https://spark.apache.org/docs/latest/running-on-kubernetes.html

TOKEN=x

/usr/local/spark/bin/spark-submit \
    --master k8s://https://127.0.0.1:16443 \
    --deploy-mode cluster \
    --name spark-pi \
    --class org.apache.spark.examples.SparkPi \
    --conf spark.kubernetes.namespace=spark \
    --conf spark.executor.instances=2 \
    --conf spark.kubernetes.authenticate.driver.serviceAccountName=spark \
    --conf spark.kubernetes.authenticate.caCertFile=/var/snap/microk8s/current/certs/ca.crt \
    --conf spark.app.name=spark-pi \
    --conf spark.kubernetes.container.image=localhost:32000/spark:3.1.2 \
    --conf spark.kubernetes.authenticate.submission.oauthToken=$TOKEN \
    local:///usr/local/spark/examples/jars/spark-examples_2.12-3.1.2.jar

# microk8s.kubectl -n kube-system get secret | grep default
# microk8s.kubectl -n kube-system describe secret default-token-xxxxx