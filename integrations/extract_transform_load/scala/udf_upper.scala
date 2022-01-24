val dataset = Seq((0, "simple"),(1, "dataset")).toDF("id","text")
val upper: String =&amp;amp;amp;gt; String =_.toUpperCase
import org.apache.spark.sql.functions.udf
val upperUDF = udf(upper)
dataset.withColumn("upper", upperUDF('text)).show