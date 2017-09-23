library(rpart)

Sys.setenv(PKG_CONFIG_PATH = "/opt/local/lib/pkgconfig")
Sys.setenv(PKG_CONFIG_PATH = "/usr/local/Cellar/gtk+/2.24.31_1/lib/pkgconfig")

install.packages("RGtk2", repos="http://www.ggobi.org/r")
install.packages("rattle", type="source")


install.packages("rattle")
install.packages("rpart.plot")
install.packages("RColorBrewer")

library(rattle)
library(rpart.plot)
library(RColorBrewer)

rm(list=ls())

# load file
train <- read.csv("input/train.csv", header = T)
test <- read.csv("input/test.csv", header = T)

fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data = train, method = "class")

# visualize
plot(fit)
text(fit)
fancyRpartPlot(fit)

prediction = predict(fit, test, type = "class")
submmit <- data.frame(PassengerId = test$PassengerId, Survived = prediction)
