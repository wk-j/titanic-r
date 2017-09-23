# load file
train <- read.csv("input/train.csv", header = T)

# summary
table(train$Survived)
table(train$Sex)
table(train$Pclass)
table(train$Embarked)

# write columns
test <- read.csv("input/test.csv", header = T)
test$Survived <- rep(0, 418)
submit <- data.frame(PassengerId = test$PassengerId, Survived = test$Survived)
write.csv(submit, file="output/theyallperish.csv", row.names = F)
