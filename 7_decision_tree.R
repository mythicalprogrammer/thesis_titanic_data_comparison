#####
# Install require package and libraries
#####

# ipak function: install and load multiple R packages.
# check to see if packages are installed. Install them if they are not, then load them into the R session.

ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg))
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}

# usage
packages <- c("rpart", 'rpart.plot', 'caret')
ipak(packages)

train_data2 <- train_data[1:802,]
test_data2 <- train_data[803:nrow(train_data),]

fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked,
             data = train_data2,
             method = "class")

# without age
fit <- rpart(Survived ~ Pclass + Sex + SibSp + Parch + Fare + Embarked,
             data = train_data2,
             method = "class")
rpart.plot(fit)

Prediction <- predict(fit, test_data2, type = "class")
submit <- data.frame(PassengerId = test_data2$PassengerId, Survived = Prediction)

confusion_table <- table(data.frame(predicted = submit$Survived,
                              reference = test_data2$Survived))


confusionMatrix(confusion_table)

write.csv(submit, file = "./submit/4_decisiontree.csv", row.names = FALSE)

