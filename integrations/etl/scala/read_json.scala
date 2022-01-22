import org.apache.spark.sql.SparkSession
val spark = SparkSession.builder().appName("Spark SQL").config("spark.config.option", "value").getOrCreate()
import spark.implicits._
val df = spark.read.json("file_location/file_name.json")
df.show()