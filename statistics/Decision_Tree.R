#CART
library(rpart)
data(iris)
fit <- rpart(Species~., data=iris)
summary(fit)
predictions <- predict(fit, iris[,1:4], type="class")
table(predictions, iris$Species)

#C4.5 (J48) from WEKA
library(RWeka)
data(iris)
fit <- J48(Species~., data=iris)
summary(fit)
predictions <- predict(fit, iris[,1:4])
table(predictions, iris$Species)



# using CART to build classifier
#import library
library(rpart)
#import training data
train.data <- read.csv("~/data/iris_train.csv", header = T)
#build decision tree classifier
classifier <- rpart(class~., data=train.data)
#show decision tree
summary(classifier)
#make prediction on training data (test the model)
classifier.predict <- predict(classifier, train.data[,1:4], type="class")
#show confusion matrix for error rate
table(classifier.predict, train.data$class)

#import test data
test.data <- read.csv("~/data/iris_test.csv", header = T)
#use classifier on test data
classifier.predict <- predict(classifier, test.data[,1:4], type="class")
#show confusion matrix for error rate
table(classifier.predict, test.data$class)