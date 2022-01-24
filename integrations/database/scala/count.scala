spark-shell --master spark://node1:7077

val logfile = sc.textFile("hdfs://node1:8020/log-dataset")
val errors = logfile.filter(_.startsWith("ERROR"))
val hdfs = errors.filter(_.containers("HDFS"))
hdfs.count()