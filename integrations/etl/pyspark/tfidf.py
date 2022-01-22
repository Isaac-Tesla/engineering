from pyspark.ml.feature import HashingTF, IDF, Tokenizer
from pyspark.shell import spark

sentences = spark.createDataFrame([
    (0.0, "This is the first sentence and includes the animals, cat, dog, and pigeon."),
    (0.0, "This second sentence also includes some animals, like cat, cat, cat, bird, cow and chicken."),
    (1.0, "Finally, another list of animals including bird, dog, dog, cat and elephant.")
], ["label", "sentence"])

token = Tokenizer(inputCol="sentence", outputCol="words")
words = token.transform(sentences)

hashTF = HashingTF(inputCol="words", outputCol="rawFeatures", numFeatures=20)
data_with_features = hashTF.transform(words)

idf = IDF(inputCol="rawFeatures", outputCol="features")
idfModel = idf.fit(data_with_features)
rescaledData = idfModel.transform(data_with_features)

rescaledData.select("label", "features").show()