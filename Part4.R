rm(list=ls())

library(rpart)
library(rattle)
library(rpart.plot)
library(RColorBrewer)

# load file
train <- read.csv("input/train.csv", header = T)
test <- read.csv("input/test.csv", header = T)

train$Name[1]
test$Survived <- NA

combi <- rbind(train, test)

combi$Name <- as.character(combi$Name)

combi$Name[1]

strsplit(combi$Name[1], split="[,.]")

strsplit(combi$Name[1], split="[,.]")[[1]]
strsplit(combi$Name[1], split="[,.]")[[1]][2]

# Title
combi$Title <- sapply(combi$Name, FUN=function(x) { strsplit(x, split="[,.]")[[1]][2]})
combi$Title <- sub(" ", "", combi$Title)


table(combi$Title)

combi$Title[combi$Title %in% c("Mme", "Mlle")] <- "Mlle"

combi$Title[combi$Title %in% c("Capt", "Don", "Major", "Sir")] <- "Sir"
combi$Title[combi$Title %in% c("Dona", "Lady", "the Countess", "Jonkheer")] <- "Lady"

combi$Title <- factor(combi$Title)

combi$FamilySize <- combi$SibSp + combi$Parch + 1


# Surename
sapply(combi$Name, FUN=function(x) {strsplit(x, split='[,.]')[[1]][1]})[2]
combi$Name[2]

combi$Surname <-  sapply(combi$Name, FUN=function(x) {strsplit(x, split='[,.]')[[1]][1]})



# Family ID
combi$FamilySize[combi$FamilySize >= 11]
table(combi$FamilySize)
table(combi$FamilySize)

combi$FamilyID[combi$FamilySize <= 2] <- "Small"

table(combi$FamilyID)

famIDs <- data.frame(table(combi$FamilyID))
famIDs[famIDs$Freq <= 2,]

combi$FamilyID[combi$FamilyID %in% famIDs$Var1] <- 'Small'
combi$FamilyID <- factor(combi$FamilyID)


fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked + Title + FamilySize + FamilyID,
             data=combi, 
             method="class")

fancyRpartPlot(fit)
