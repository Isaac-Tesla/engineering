from pyspark.ml import Pipeline
from pyspark.ml.classification import LogisticRegression
from pyspark.ml.feature import HashingTF, Tokenizer
from pyspark.shell import spark

trainingData = spark.createDataFrame([
    (0, "a b c d e f g spark", 1.0),
    (1, "d b z", 0.0),
    (2, "spark f g h", 1.0),
    (3, "hadoop the elephant", 0.0)
], ["id", "text", "label"])

tokenizer = Tokenizer(inputCol="text", outputCol="words")
hashingTF = HashingTF(inputCol=tokenizer.getOutputCol(), outputCol="features")
lr = LogisticRegression(maxIter=20, regParam=0.001)
pipeline = Pipeline(stages=[tokenizer, hashingTF, lr])
model = pipeline.fit(trainingData)

testData = spark.createDataFrame([
    (4, "spark a z l"),
    (5, "p q r"),
    (6, "spark spark hadoop spark"),
    (7, "apache hadoop spark")
], ["id", "text"])

prediction = model.transform(testData)
selected = prediction.select("id", "text", "probability", "prediction")
for row in selected.collect():
    rid, text, prob, prediction = row
    print(
        "(%d, %s) --> prob=%s, prediction=%f" % (
            rid, text, str(prob), prediction
        )
    )