rm(list=ls())

# load file
train <- read.csv("input/train.csv", header = T)
test <- read.csv("input/test.csv", header = T)

train$Name[1]
test$Survived <- NA

combi <- rbind(train, test)

# TODO
