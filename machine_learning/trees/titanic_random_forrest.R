# Titanic Dataset - Random forrest

#import library
library(randomForest)

#load training set
train.data <- read.csv("../../data/titanic_train.csv", header = T)

#delete all empty rows as randomForest only works if all attributes are full
summary(train.data)

#train classifier
classifier <- randomForest(Survived~., train.data)

#summary of classifier
summary(classifier)

# make predictions
predictions <- predict(classifier, test.data, type="class")

# Confusion matrix of predictions
table(classifier.predict, train.data$Survived)

#import test data
test.data <- read.csv("../../data/titanic_test.csv", header = T)

#use classifier on test data
classifier.predict <- predict(classifier, test.data, type="class")
