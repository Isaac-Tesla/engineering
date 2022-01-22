#Titanic - CART decision tree classifier

#import library
library(rpart)

#import training data
train.data <- read.csv("../../data/titanic_train.csv", header = T)

#show training data
str(train.data)

#build decision tree classifier
classifier <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked,
                    data=train.data,
                    method="class")

#show decision tree classifier summary
summary(classifier)

#visually show decision tree classifier
plot(classifier)
text(classifier)

#make prediction on training data (test the model)
classifier.predict <- predict(classifier, train.data, type="class")

#show confusion matrix for error rate
table(classifier.predict, train.data$Survived)

#import test data
test.data <- read.csv("../../data/titanic_test.csv", header = T)

#use classifier on test data
Survived <- predict(classifier, test.data, type="class")

#add predictions to dataframe
predictions <- cbind(test.data, Survived)

#get only the required columns
forKaggle <- data.frame(predictions$PassengerId, predictions$Survived)

#relabel columns
colnames(forKaggle) = c("PassengerId", "Survived")

#save output into CSV file
write.csv(forKaggle, file = "titanicCARTSolution.csv", row.names = FALSE)
