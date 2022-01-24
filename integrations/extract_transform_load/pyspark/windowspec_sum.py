from pyspark.shell import spark
from pyspark.sql.window import Window
from pyspark.sql.functions import sum


def _windowspec():

    data_list = [("US", "536365","2021-05-15", "600"),
                ("US", "536365","2021-05-17", "500"),
                ("US", "536366","2021-05-14", "200"),
                ("IN", "536367","2021-05-16", "600"),
                ("IN", "536367","2021-05-20", "800")]

    df = spark.createDataFrame(data_list).toDF("Country", "CustomerID", "PurchaseDate", "Amount")

    windowSpec = Window \
        .partitionBy("Country") \
        .orderBy("PurchaseDate") \
        .rowsBetween(Window.unboundedPreceding, Window.currentRow)

    df.withColumn("CumulativePurchase", sum("Amount").over(windowSpec)).show()


def main():
    _windowspec()


if __name__=="__main__":
    main()