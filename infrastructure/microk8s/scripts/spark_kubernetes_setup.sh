#!/usr/bin/env bash

# Using the spark dockerfiles, build the images and upload to microk8s repository
# https://spark.apache.org/docs/latest/running-on-kubernetes.html

SPARK_VERISON=3.2.0
HADOOP_VERSION=3.2
TEMP_DIR=./temp
mkdir $TEMP_DIR
cd $TEMP_DIR
wget https://downloads.apache.org/spark/spark-${SPARK_VERISON}/spark-${SPARK_VERISON}-bin-hadoop${HADOOP_VERSION}.tgz
tar xvf spark-*

echo "Running the docker-image-tool with PySpark image binding..."
cd spark-${SPARK_VERISON}-bin-hadoop${HADOOP_VERSION}
./bin/docker-image-tool.sh -t ${SPARK_VERISON} -p ./kubernetes/dockerfiles/spark/bindings/python/Dockerfile build
echo "Help - ./spark-${SPARK_VERISON}-bin-hadoop${HADOOP_VERSION}/bin/docker-image-tool.sh -h"
cd ../..
rm -rf $TEMP_DIR

echo "Push to the container registry on Microk8s."
docker tag spark:${SPARK_VERISON} localhost:32000/spark:${SPARK_VERISON}
docker push localhost:32000/spark:${SPARK_VERISON}