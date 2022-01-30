# apache-nifi-docker-compose
    A basic setup of Apache Nifi to run with Docker Compose.


## To run containers
    docker-compose up -d --build nifi zookeeper

    Note: the image will take around 5 minutes to start on port 8090.


## To stop containers
    docker stop nifi zookeeper


## To clean up images
    sudo docker system prune -a --volumes



# apache-spark-docker-compose
    A docker-compose cluster of Apache Spark for some local machine testing. 
    Some extra database connectors are in the requirements.txt for the image
    just in case. The base image is Ubuntu and is quite large and will take 
    some time to setup.

    This is for familiarity and testing purposes only, not for a production
    system.

## To run containers
    docker-compose up -d --build spark-master spark-worker-1 spark-worker-2

    Once running go to localhost:8080 to see the Master node dashboard.

* To run the hello world example:
    ```
    docker exec spark-master bash ./opt/spark/bin/spark-submit --master spark://master:7077 /pyspark_example/hello-world.py 1000
    ```


## To stop containers
    docker stop spark-master spark-worker-1 spark-worker-2


## To clean up images
    sudo docker system prune -a --volumes