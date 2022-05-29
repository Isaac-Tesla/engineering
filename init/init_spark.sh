#!/usr/bin/env bash


<<COMMENT

  Summary:
  The following code will install Spark local and PySpark with requirements.

COMMENT


# Install the requirements
sudo apt-get install -y --fix-missing \
    maven \
    mlocate \
    python3-pip \
    libodbc1 unixodbc unixodbc-dev

# Spark
SPARK_VERSION=3.2.1
HADOOP_VERSION=3.2
SCALA_VERSION=2.13
wget https://downloads.apache.org/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}-scala${SCALA_VERSION}.tgz 
tar xvf spark-*
sudo mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}-scala${SCALA_VERSION} /opt/spark
rm -rf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}-scala${SCALA_VERSION}.tgz
#RUN chmod +x /opt/spark/spark-${SPARK_VERSION}-bin-hadoop3.2/sbin/start-master.sh
echo "export SPARK_HOME=/opt/spark" >> ~/.profile
echo "export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin" >> ~/.profile
echo "export PYSPARK_PYTHON=/usr/bin/python3" >> ~/.profile
# 	export SPARK_EXAMPLES_JAR=/usr/local/spark/examples/jars/spark-examples_2.12-3.0.0.jar


# Jupyter Notebook
# RUN export PYSPARK_DRIVER_PYTHON="jupyter"
# RUN export PYSPARK_DRIVER_PYTHON=OPTS="notebook"
# RUN export PYSPARK_PYTHON=python3

echo SPARK_NO_DAEMONIZE=true > /opt/spark/conf/spark-env.sh

# Add PySpark and common dependencies (e.g. cloud storage)
pip3 install --no-warn-script-location \
  azure-storage-blob \
  apache-beam \
  boto3 \
  botocore \
  findspark \
  google-cloud-storage \
  jupyter \
  kafka-python \
  numpy \
  pandas \
  py4j \
  pyspark \
  pytest \
  cassandra-driver \
  fastparquet \
  pathos \
  psycopg2_binary \
  pyarrow \
  pyhocon \
  pymongo \
  pyodbc \
  python-dotenv \
  sqlalchemy \
  snowflake-connector-python
