from pyspark.shell import spark
from pyspark.sql.functions import col, expr
from pyspark.sql.types import IntegerType


def _group_by_example_worked():

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

    df2 = df.withColumn("key", col("value") % 1000).show()

    # +-----+---+
    # |value|key|
    # +-----+---+
    # | 1002|  2|
    # | 3001|  1|
    # | 4002|  2|
    # | 2003|  3|
    # | 2002|  2|
    # | 3004|  4|
    # | 1003|  3|
    # | 4006|  6|
    # +-----+---+

    df.withColumn("key", col("value") % 1000) \
        .groupBy("key") \
        .agg(expr("count(key) as count"), expr("sum(key) as sum")) \
        .orderBy(col("key").desc()) \
        .select("*") \
        .show()

    # +---+-----+---+
    # |key|count|sum|
    # +---+-----+---+
    # |  6|    1|  6|
    # |  4|    1|  4|
    # |  3|    2|  6|
    # |  2|    3|  6|
    # |  1|    1|  1|
    # +---+-----+---+

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



def main():
    _group_by_example_worked()


if __name__=="__main__":
    main()