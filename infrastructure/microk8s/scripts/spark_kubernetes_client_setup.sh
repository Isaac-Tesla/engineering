#!/usr/bin/env bash

# To run Spark on Kubernetes, you must have 
#   a client setup on your local machine to 
#   run the driver program and submit jobs.
#   This code is to install the driver 
#   program on your local machine.

SPARK_VERISON=3.2.0
HADOOP_VERSION=3.2
SPARK_DIR=/opt/spark

# Ensure your Ubuntu is up to date
sudo apt-get update -y
sudo apt-get install -y software-properties-common
sudo apt-get install -y --fix-missing \
    curl \
    default-jdk \
    git \
    maven \
    mlocate \
    python3-pip \
    scala \
    wget \
    libodbc1 unixodbc unixodbc-dev

# Install Spark on local (client) machine
wget https://downloads.apache.org/spark/spark-${SPARK_VERISON}/spark-${SPARK_VERISON}-bin-hadoop${HADOOP_VERSION}.tgz
tar xvf spark-*
sudo mv spark-${SPARK_VERISON}-bin-hadoop${HADOOP_VERSION} ${SPARK_DIR}
sudo rm -rf spark-${SPARK_VERISON}-bin-hadoop${HADOOP_VERSION}.tgz

echo "export SPARK_HOME=/opt/spark" >> ~/.profile
echo "export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin" >> ~/.profile
echo "export PYSPARK_PYTHON=/usr/bin/python3" >> ~/.profile
echo "export SPARK_EXAMPLES_JAR=/usr/local/spark/examples/jars/spark-examples_2.12-3.1.2.jar"  >> ~/.profile
echo SPARK_NO_DAEMONIZE=true > /opt/spark/conf/spark-env.sh

pip3 install \
    numpy \
    pathos \
    pandas \
    psycopg2_binary \
    pyarrow \
    pyhocon \
    pyodbc \
    pyspark \
    pytest \
    python-dotenv \
    sqlalchemy


NAMESPACE=spark

echo "Namespace is $NAMESPACE"
NS=$(microk8s kubectl get namespace $NAMESPACE --ignore-not-found);
if [[ "$NS" ]]; then
  echo "Skipping creation of namespace $NAMESPACE - already exists";
else
  echo "Creating namespace $NAMESPACE";
  microk8s kubectl create namespace $NAMESPACE;
fi;

microk8s kubectl create serviceaccount spark
microk8s kubectl create clusterrolebinding spark-role --clusterrole=edit --serviceaccount=default:spark --namespace=$NAMESPACE