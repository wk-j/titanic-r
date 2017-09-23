library(rpart)

#install.packages("RGtk2")
#install.packages("carioDevice")
# install.packages("rattle", repos="http://rattle.togaware.com", type="source")
install.packages("RGtk2", dependencies = T, type = 'mac.binary')

install.packages("rattle")
install.packages("rpart.plot")
install.packages("RColorBrewer")

library(rattle)

rm(list=ls())

# load file
train <- read.csv("input/train.csv", header = T)
test <- read.csv("input/test.csv", header = T)

fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data = train, method = "class")

plot(fit)
text(fit)


prediction = predict(fit, test, type = "class")
submmit <- data.frame(PassengerId = test$PassengerId, Survived = prediction)
