
library("tidyverse")

# 1. Collect in datasets
sim_data <- read.csv('U:/metadata.csv', header=TRUE, na.strings=c("","NA"))
sai_data <- read.csv('U:/prices.csv', header=TRUE, na.strings=c("","NA"))
innodata_data <- read.csv('U:/page_count.csv', header=TRUE, na.strings=c("","NA"))

# 2. Aggregate to a dataset with all documents with prices having all attributes
# merge two data frames by ID
total <- merge(sim_data,sai_data,by="Designation")
compiled <- merge(total, innodata_data, by="Designation")

summary(compiled)
print(colnames(compiled))

# 3. Drop columns by name
engineered_data <- compiled[ , -which(names(compiled) %in% c("Originator","Non.chargeable.pages.at.end","Non.chargeable.pages.at.start","Watermarked.","Comments.","Anomalies", "Designation","Note","X", "Notes.from.MP", "Binary.URI", "Searchable.URI", "Comments", "X.GST", "URI", "Full.Title", "Synopsis"))]
# print(colnames(engineered_data))
# summary(engineered_data)
names(engineered_data)[names(engineered_data) == 'X.GST'] <- 'PRICE'


# output to CSV for excel to do date calculations and multi-category splits
write.csv(engineered_data, 'U:/stage1.csv')

# 4. import updated dataset
data <- read.csv('U:/dataset.csv', header=TRUE)

# make numeric....
test <- data
test <- sapply(test, as.numeric)

# Spearman correlation (non-parametric Pearson; doesn't rely on assumptions that data are drawn from a given parametric family of distributions)
spearcor <- cor(test, use="complete.obs", method="spearman")
write.table(spearcor, 'U:/spearmanCorrelation.tsv', col.names=TRUE,row.names=TRUE,sep="\t",quote=FALSE)

# Pearson Correlation / product momentum correlation coefficient
pearcor <- cor(test, use="complete.obs", method="pearson")

# Drop anything with a near zero correlation (keep all above 5%) for data science models
clean <- test
# colnames(clean)
clean_list <- c("Project.Type.amendment", "Project.Type.identical")
cleaned <- clean[ , !(colnames(clean) %in% clean_list) ] 

# Function to scale
scale_data <- function(x){(x-min(x))/(max(x)-min(x))}
# convert factors to numeric types
cleaned <- as.data.frame(cleaned)
cleaned$Publish.Date <- scale_data(cleaned$Publish.Date)
cleaned$Date.Publication.Review <- scale_data(cleaned$Date.Publication.Review)
cleaned$Reconfirmation.Date <- scale_data(cleaned$Reconfirmation.Date)
cleaned$Withdrawal.Date <- scale_data(cleaned$Withdrawal.Date)

really_cleaned <- na.omit(cleaned)


######################################
# MODEL 1 - ANN
######################################
# Extract required columns to train and test dataset - using 5 dimensions for simplicity
train <- really_cleaned[c(2:35, 1)]
test <- really_cleaned[c(2:35)]

# split data
index <- sample(nrow (train), round(0.6 * nrow(train)))
train.wp <- train[index,]
test.wp <- train[-index,]

# Neural network model
library(neuralnet)
allVars <- colnames(train)
predictorVars <- allVars[!allVars%in%"PRICE"]
predictorVars <- paste(predictorVars, collapse = "+")
form = as.formula(paste("PRICE~", predictorVars, collapse = "+"))

# Prediction Model
nn_model <- neuralnet(formula = form, train.wp, hidden = c(5, 3), linear.output = TRUE)

# Weights
nn_model$net.result
plot(nn_model)

# Predicting
prediction1 <- compute(nn_model, test)
str(prediction1)

prediction1$net.result

table(prediction1)

# Convert the scaled values to original 
scale_data_2 <- function(prediction) {
  prediction1$net.result * (max(train$price)-min(train$price)) + min(train$price)
}

ActualPrediction <-  prediction1$net.result * (max(train$price)-min(train$price)) + min(train$price)
table(ActualPrediction)



######################################
# MODEL 2 - K-means
######################################

#K-Means
#install.packages("kmeans")
setRepositories()
#install.packages("flexclust")
#install.packages("clue")
library("flexclust")
library("dplyr")
library("clue")

# split data
index <- sample(nrow (train), round(0.6 * nrow(train)))
km_train.data <- train[index,]

(km <- kmeans(km_train.data, 9))

km_truth <- really_cleaned
(km_t <- kmeans(km_truth, 9))

ground_truth <- cl_predict(km_t, newdata=really_cleaned)
predictions <- cl_predict(km, newdata=really_cleaned)

d <- table(ground_truth, predictions)

pMatrix.min <- function(A, B) { 
  n <- nrow(A) 
  D <- matrix(NA, n, n) 
  for (i in 1:n) { 
    for (j in 1:n) { 
      D[j, i] <- (sum((B[j, ] - A[i, ])^2)) 
    }
  } 
  vec <- c(solve_LSAP(D)) 
  list(A=A[vec,], pvec=vec) 
} 

B <- diag(1, nrow(d))
X <- pMatrix.min(d,B) 
X$A

sum(diag(X$A))/sum(X$A) # overall accuracy - 21.58%
1-sum(diag(X$A))/sum(X$A) # incorrect classification  - 78.42%