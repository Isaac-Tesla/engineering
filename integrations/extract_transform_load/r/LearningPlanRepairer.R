# script to take in CSV and aggregate only if new row OR if completion % is greater.

# import CSV
learningPlan <- read.csv("C:/File1.csv", header = T)
newLearningPlan <- read.csv("C:/File2.csv", header = T)

# head(learningPlan)

# update only values where greater than
for (row in 1:nrow(learningPlan)){
  for (row in 1:nrow(newLearningPlan)){
    print(newLearningPlan$User.ID[row])
    
    if(newLearningPlan$id[row] == learningPlan$id[row] & newLearningPlan$User.ID[row] == learningPlan$User.ID[row] & learningPlan$Completeness > newLearningPlan$Completeness){
      newLearningPlan$Completeness = learningPlan$Completeness
    }
    else
    {}
       
  }
}

for (row in 1:nrow(newLearningPlan)){
  print("New", newLearningPlan$Completeness[row], "Old", learningPlan$Completeness[row])
}

#create combination for vector match
vector1 <- c(learningPlan$User.ID, learningPlan$id)
vector2 <- c(newLearningPlan$User.ID, newLearningPlan$�..id)

x <- match(vector1, vector2)