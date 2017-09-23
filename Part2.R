rm(list=ls())

# load file
train <- read.csv("input/train.csv", header = T)

# majority of femails aboard survived
summary(train$Sex)
prop.table(table(train$Sex, train$Survived), 1)


test <- read.csv("input/test.csv", header = T)
test$Survived <- 0
test$Survived[test$Sex == 'female'] <- 1

# write.csv(test, file="output/Part2.csv", row.names = F)
# write.table(test,  sep=",", file = "output/Part2.csv", row.names = F, col.names = F)

submit <- data.frame(PassengerId = test$PassengerId, Survived = test$Survived)
write.csv(submit, file = "output/Part2-AllFemaleSurvived.csv", row.names = FALSE)

summary(train$Age)

# fill child
train$Child <- 0
train$Child[train$Age < 18] <- 1

aggregate(Survived ~ Child + Sex, data=train, FUN=sum)
aggregate(Survived ~ Child + Sex, data=train, FUN=length)

aggregate(Survived ~ Child + Sex, data=train, FUN=function(x) { sum(x) / length(x) })
