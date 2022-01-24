import com.mongodb.spark._
import com.mongodb.spark.config.ReadConfig
import com.typesafe.scalalogging.slf4j.LazyLogging
import org.apache.spark.{SparkConf, SparkContext}


object mongodb_query extends App with LazyLogging {

  val conf = new SparkConf()
    .setAppName("mongocars")
    .setMaster("local[*]")

  val sc = new SparkContext(conf)
  val cfg = ReadConfig(Map("uri" -> "mongodb://127.0.0.1/", "database" -> "testdb", "collection" -> "cars"))
  val df = sc.loadFromMongoDB(cfg).toDF()

  df.printSchema()
  df.show()

  println( "Average Car Price by State" )
  df.groupBy("state", "city")
    .sum("price")
    .withColumnRenamed("sum(price)", "count")
    .groupBy("state")
    .avg("count")
    .withColumnRenamed("avg(count)", "avgCarPrice")
    .show()

}