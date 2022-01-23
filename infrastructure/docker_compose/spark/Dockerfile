FROM ubuntu:21.04

# Add repositories
RUN apt-get update -y
RUN apt-get install -y software-properties-common

# Install the requirements
RUN apt-get install -y --fix-missing \
    curl \
    default-jdk \
    git \
    maven \
    mlocate \
    python3-pip \
    scala \
    wget \
    libodbc1 unixodbc unixodbc-dev

# Apache Spark
RUN wget https://downloads.apache.org/spark/spark-3.1.2/spark-3.1.2-bin-hadoop3.2.tgz
RUN tar xvf spark-*
RUN mv spark-3.1.2-bin-hadoop3.2 /opt/spark
RUN rm -rf spark-3.1.2-bin-hadoop3.2.tgz
RUN echo "export SPARK_HOME=/opt/spark" >> ~/.profile
RUN echo "export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin" >> ~/.profile
RUN echo "export PYSPARK_PYTHON=/usr/bin/python3" >> ~/.profile
RUN echo SPARK_NO_DAEMONIZE=true > /opt/spark/conf/spark-env.sh

# Add Python requirements
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt