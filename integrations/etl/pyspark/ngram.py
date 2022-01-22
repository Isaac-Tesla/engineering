from pyspark.shell import spark
from pyspark.ml.feature import NGram

df = spark.createDataFrame([
    (0, ["Spark", "word", "cat", "dog", "chicken"]),
    (1, ["fried", "turkey", "elephant", "bird", "goose", "linx", "bat"]),
    (2, ["vodka", "beer", "slice", "watermelon", "eggplant"])
], ["id", "words"])

ngram = NGram(n=2, inputCol="words", outputCol="ngrams")
ngram_df = ngram.transform(df)
ngram_df.select("ngrams").show(truncate=False)