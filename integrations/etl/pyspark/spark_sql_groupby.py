from pyspark.shell import spark
from pyspark.sql.types import IntegerType
from pyspark.sql.functions import col
import pyspark.sql.functions as f
 
a = [2002, 4001, 3002, 2003, 1002, 4004, 1003, 3006]
b = spark.createDataFrame(a, IntegerType()).withColumn("x", col("value") % 1000)

b.show()

c = b.groupBy(col("x"))\
    .agg(f.count("x"), f.sum("value"))\
    .drop("x")\
    .toDF("count", "total")\
    .orderBy(col("count").desc(), col("total"))\
    .limit(1)\
    .show()