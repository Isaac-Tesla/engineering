"""
Task A - Clustering
Download BBC sports dataset from the Cloud. This dataset consists of 737 documents from the BBC Sport website
corresponding to sports news articles in five topical areas from 2004-2005. There are 5 class labels: athletics, cricket,
football, rugby, tennis. The original dataset and raw text files can be downloaded from here
1. There are 3 files in the dataset corresponding to the feature matrix, the class labels and the term dictionary.
You need to read these files in Python notebook and store in variables X, trueLabels, and terms.
"""

### Import libraries
import numpy as np # linear algebra
import pandas as pd # data processing

### Import data
X = pd.read_csv("Assessment-task-1/bbcsport_classes.csv", header=None) # Class labels
trueLabels = pd.read_csv("Assessment-task-1/bbcsport_mtx.csv", header=None) # Feature Matrix
terms = pd.read_csv("Assessment-task-1/bbcsport_terms.csv", header=None) # Term Dictionary

### Confirm dimensions are correct from import
print("X: ", X.shape)
print("trueLabels: ", trueLabels.shape)
print("terms: ", terms.shape)

"""
2. Next perform K-means clustering with 5 clusters using Euclidean distance as similarity measure. Evaluate the
clustering performance using adjusted rand index and adjusted mutual information. Report the clustering
performance averaged over 50 random initializations of K-means
"""
### Scale data / normalise vectors
from sklearn.feature_extraction.text import TfidfTransformer
transformer = TfidfTransformer(norm='l2', use_idf=True, smooth_idf=True, sublinear_tf=False)
tfidf = transformer.fit_transform(trueLabels)
trueLabels_transformed = tfidf.toarray()

### Confirm scaled dataset
print(trueLabels_transformed)

from sklearn.cluster import KMeans
seed = 5
km_cluster = KMeans(n_clusters=5, random_state=seed)
km_cluster.fit(trueLabels_transformed)



labels=np.array(X).flatten()

### Main loop
number = 50
ARI = 0
AMI = 0
seed = 123
count = 1  # loop number
predicted_labels = km_cluster.labels_ # predicted labels

from sklearn import metrics
import random
while count < number:
    km_cluster = KMeans(n_clusters=5, random_state=seed)
    km_cluster.fit(trueLabels_transformed)

    ### Calculate ARI and AMI for each run
    ari = metrics.adjusted_rand_score(labels, predicted_labels)
    ami = metrics.adjusted_mutual_info_score(labels, predicted_labels)

    ### Add current measures to totals
    ARI = ARI + ari
    AMI = AMI + ami

    ### Average the totals
    average_ARI = ARI / number
    average_AMI = AMI / number

    ### Stochastic randomness to avoid identical convergence for KMeans
    seed = random.randint(1,101)
    count = count + 1

print("ARI average: ", average_ARI, "\nAMI average: ", average_AMI)

euclidean_centroids = km_cluster.cluster_centers_
print(euclidean_centroids, "\n", euclidean_centroids.shape)

"""
3. Repeat K-means clustering with 5 clusters using a similarity measure other than Euclidean distance. Evaluate
the clustering performance over 50 random initializations of K-means using adjusted rand index and adjusted
mutual information. Report the clustering performance and compare it with the results obtained in step 2
"""

### Main loop
number = 50
ARI = 0
AMI = 0
seed = 123
count = 1  # loop number
predicted_labels = km_cluster.labels_ # predicted labels

### As the dataset is already close to cosine similarity, we normalise the labels
from sklearn.preprocessing import normalize
normalised_column = normalize(trueLabels_transformed, axis = 1)

while count < number:
    ### Calculate
    km_cluster = KMeans(n_clusters=5, random_state=seed)
    km_cluster.fit(normalised_column)

    ### Calculate ARI and AMI for each run
    ari = metrics.adjusted_rand_score(labels, predicted_labels)
    ami = metrics.adjusted_mutual_info_score(labels, predicted_labels)

    ### Add current measures to totals
    ARI = ARI + ari
    AMI = AMI + ami

    ### Average the totals
    average_ARI = ARI / number
    average_AMI = AMI / number

    ### Stochastic randomness to avoid identical convergence for KMeans
    seed = random.randint(1,101)
    count = count + 1

print("ARI average: ", average_ARI, "\nAMI average: ", average_AMI)

cosine_centroids = km_cluster.cluster_centers_
print(cosine_centroids, "\n", cosine_centroids.shape)




"""
4. For clustering cases (Euclidean distance and the other similarity measure), visualize the cluster centres using
Tag cloud using Python package WordCloud.
"""

### Import libraries
import matplotlib.pyplot as plt
from wordcloud import WordCloud

### Build dataframe for wordcloud output
centroid_1 = terms
centroid_1[1] = euclidean_centroids[0][:] # grab the first row from the numpy array
centroid_1_frequencies = {}
for frequency_counter, centroid_1_values in centroid_1.values:
    centroid_1_frequencies[frequency_counter] = centroid_1_values
### Output word clouds
wordcloud = WordCloud()
wordcloud.generate_from_frequencies(frequencies=centroid_1_frequencies)
plt.figure()
plt.title('Wordcloud for Euclidean centroid 1')
plt.imshow(wordcloud, interpolation="bilinear")
plt.axis("off")
plt.show()


centroid_2 = terms
centroid_2[1] = euclidean_centroids[1][:] # grab the second row from the numpy array
centroid_2_frequencies = {}
for frequency_counter, centroid_2_values in centroid_2.values:
    centroid_2_frequencies[frequency_counter] = centroid_2_values
wordcloud = WordCloud()
wordcloud.generate_from_frequencies(frequencies=centroid_2_frequencies)
plt.figure()
plt.title('Wordcloud for Euclidean centroid 2')
plt.imshow(wordcloud, interpolation="bilinear")
plt.axis("off")
plt.show()

centroid_3 = terms
centroid_3[1] = euclidean_centroids[2][:] # grab the third row from the numpy array
centroid_3_frequencies = {}
for frequency_counter, centroid_3_values in centroid_3.values:
    centroid_3_frequencies[frequency_counter] = centroid_3_values
wordcloud.generate_from_frequencies(frequencies=centroid_3_frequencies)
plt.figure()
plt.title('Wordcloud for Euclidean centroid 3')
plt.imshow(wordcloud, interpolation="bilinear")
plt.axis("off")
plt.show()

centroid_4 = terms
centroid_4[1] = euclidean_centroids[3][:] # grab the fourth row from the numpy array
centroid_4_frequencies = {}
for frequency_counter, centroid_4_values in centroid_4.values:
    centroid_4_frequencies[frequency_counter] = centroid_4_values
wordcloud.generate_from_frequencies(frequencies=centroid_4_frequencies)
plt.figure()
plt.title('Wordcloud for Euclidean centroid 4')
plt.imshow(wordcloud, interpolation="bilinear")
plt.axis("off")
plt.show()

centroid_5 = terms
centroid_5[1] = euclidean_centroids[4][:] # grab the fifth row from the numpy array
centroid_5_frequencies = {}
for frequency_counter, centroid_5_values in centroid_5.values:
    centroid_5_frequencies[frequency_counter] = centroid_5_values
wordcloud.generate_from_frequencies(frequencies=centroid_5_frequencies)
plt.figure()
plt.title('Wordcloud for Euclidean centroid 5')
plt.imshow(wordcloud, interpolation="bilinear")
plt.axis("off")
plt.show()



### Repeated again for Cosine similarity

cosine_centroid_1 = terms
cosine_centroid_1[1] = cosine_centroids[0][:] # grab the first row from the numpy array
cosine_centroid_1_frequencies = {}
for frequency_counter, cosine_centroid_1_values in cosine_centroid_1.values:
    cosine_centroid_1_frequencies[frequency_counter] = cosine_centroid_1_values
### Output word clouds
wordcloud = WordCloud()
wordcloud.generate_from_frequencies(frequencies=cosine_centroid_1_frequencies)
plt.figure()
plt.title('Wordcloud for Cosine centroid 1')
plt.imshow(wordcloud, interpolation="bilinear")
plt.axis("off")
plt.show()

cosine_centroid_2 = terms
cosine_centroid_2[1] = cosine_centroids[1][:] # grab the second row from the numpy array
cosine_centroid_2_frequencies = {}
for frequency_counter, cosine_centroid_2_values in cosine_centroid_2.values:
    cosine_centroid_2_frequencies[frequency_counter] = cosine_centroid_2_values
### Output word clouds
wordcloud = WordCloud()
wordcloud.generate_from_frequencies(frequencies=cosine_centroid_2_frequencies)
plt.figure()
plt.title('Wordcloud for Cosine centroid 2')
plt.imshow(wordcloud, interpolation="bilinear")
plt.axis("off")
plt.show()

cosine_centroid_3 = terms
cosine_centroid_3[1] = cosine_centroids[2][:] # grab the second row from the numpy array
cosine_centroid_3_frequencies = {}
for frequency_counter, cosine_centroid_3_values in cosine_centroid_3.values:
    cosine_centroid_3_frequencies[frequency_counter] = cosine_centroid_3_values
### Output word clouds
wordcloud = WordCloud()
wordcloud.generate_from_frequencies(frequencies=cosine_centroid_3_frequencies)
plt.figure()
plt.title('Wordcloud for Cosine centroid 3')
plt.imshow(wordcloud, interpolation="bilinear")
plt.axis("off")
plt.show()

cosine_centroid_4 = terms
cosine_centroid_4[1] = cosine_centroids[3][:] # grab the second row from the numpy array
cosine_centroid_4_frequencies = {}
for frequency_counter, cosine_centroid_4_values in cosine_centroid_4.values:
    cosine_centroid_4_frequencies[frequency_counter] = cosine_centroid_4_values
### Output word clouds
wordcloud = WordCloud()
wordcloud.generate_from_frequencies(frequencies=cosine_centroid_4_frequencies)
plt.figure()
plt.title('Wordcloud for Cosine centroid 4')
plt.imshow(wordcloud, interpolation="bilinear")
plt.axis("off")
plt.show()

cosine_centroid_5 = terms
cosine_centroid_5[1] = cosine_centroids[4][:] # grab the second row from the numpy array
cosine_centroid_5_frequencies = {}
for frequency_counter, cosine_centroid_5_values in cosine_centroid_5.values:
    cosine_centroid_5_frequencies[frequency_counter] = cosine_centroid_5_values
### Output word clouds
wordcloud = WordCloud()
wordcloud.generate_from_frequencies(frequencies=cosine_centroid_5_frequencies)
plt.figure()
plt.title('Wordcloud for Cosine centroid 5')
plt.imshow(wordcloud, interpolation="bilinear")
plt.axis("off")
plt.show()


"""
Task B - (Dimensionality Reduction using PCA/SVD
For the provided BBC sports dataset, perform PCA and plot the captured variance with respect to increasing
latent dimensionality. What is the minimum dimension that captures (a) at least 95% variance and (b) at
least 98% variance?
"""

### Import library for Principle Components Analysis
import numpy as np
np.set_printoptions(threshold=100)
from sklearn.decomposition import PCA
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.preprocessing import scale

### Scale and normalise
trueLabels_normalised = scale(trueLabels)
pca = PCA(n_components=4613) # limit the amount of components to the dataset
pca.fit(trueLabels_normalised) # map to the labels
#trueLabels_pca = pca.transform(trueLabels_normalised)
pca.explained_variance_ratio_ # print the array

### Cumulative variance
cumulative_variance=np.cumsum(np.round(pca.explained_variance_ratio_, decimals=4)*100)
print(cumulative_variance)
plt.plot(cumulative_variance)
plt.xlabel("Principal components")
plt.ylabel("Variance")
print(cumulative_variance.shape)

pca=PCA(0.95)
trueLabels_normalised_95=pca.fit_transform(trueLabels_normalised)
print("Minimum dimensions for 95% variance is:", trueLabels_normalised_95.shape[1])

pca=PCA(0.98)
trueLabels_normalised_98=pca.fit_transform(trueLabels_normalised)
print("Minimum dimensions for 98% variance is:", trueLabels_normalised_98.shape[1])
