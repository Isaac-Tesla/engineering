from pyspark.shell import spark
from pyspark.sql.functions import col, expr
from pyspark.sql.types import IntegerType


def _group_by_example():

    mylist = [1002, 3001, 4002, 2003, 2002, 3004, 1003, 4006]

    df = spark.createDataFrame(mylist, IntegerType()).toDF("value")

    df.show()

    # +-----+
    # |value|
    # +-----+
    # | 1002|
    # | 3001|
    # | 4002|
    # | 2003|
    # | 2002|
    # | 3004|
    # | 1003|
    # | 4006|
    # +-----+

    df.withColumn("key", col("value") % 1000) \
        .groupBy("key") \
        .agg(expr("count(key) as count"), expr("sum(key) as sum")) \
        .orderBy(col("key").desc()) \
        .limit(1) \
        .select("count", "sum") \
        .show()

    # +-----+---+
    # |count|sum|
    # +-----+---+
    # |    1|  6|
    # +-----+---+


# To run in the local Docker cluster
# docker exec spark-master bash ./opt/spark/bin/spark-submit --master spark://master:7077 pyspark_example/group-by-example.py 1000

def main():

    _group_by_example()



if __name__=="__main__":
    main()