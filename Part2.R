rm(list=ls())

# load file
train <- read.csv("input/train.csv", header = T)
test <- read.csv("input/test.csv", header = T)

t1 <- function() {
  
  # majority of femails aboard survived
  summary(train$Sex)
  prop.table(table(train$Sex, train$Survived), 1)
  
  test$Survived <- 0
  test$Survived[test$Sex == 'female'] <- 1
  
  # write.csv(test, file="output/Part2.csv", row.names = F)
  # write.table(test,  sep=",", file = "output/Part2.csv", row.names = F, col.names = F)
  
  submit <- data.frame(PassengerId = test$PassengerId, Survived = test$Survived)
  write.csv(submit, file = "output/Part2-AllFemaleSurvived.csv", row.names = FALSE)
}

t2 <- function() {
  summary(train$Age)
  # fill child
  train$Child <- 0
  train$Child[train$Age < 18] <- 1
  
  aggregate(Survived ~ Child + Sex, data=train, FUN=sum)
  aggregate(Survived ~ Child + Sex, data=train, FUN=length)
  aggregate(Survived ~ Child + Sex, data=train, FUN=function(x) { sum(x) / length(x) })
  
  train$Fare2 <- "30+"
  train$Fare2[train$Fare < 30 & train$Fare >= 20] <- "20-30"
  train$Fare2[train$Fare < 20 & train$Fare >= 10] <- "10-20"
  train$Fare2[train$Fare < 10] <- "<10"
  
  aggregate(Survived ~ Fare2 + Pclass + Sex, data=train, FUN=function(x) {sum(x)/length(x)})
  
  test$Survived <- 0 
  test$Survived[test$Sex == "female"] <- 1
  test$Survived[test$Sex == "female" & test$Pclass == 3 & test$Fare >= 20] <- 0
  
  submit <- data.frame(PassengerId = test$PassengerId, Survived = test$Survived)
  write.csv(submit, file = "output/Part2-NoClass3.csv", row.names = FALSE)
}
