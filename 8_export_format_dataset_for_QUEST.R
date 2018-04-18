train_data2$PassengerId <- NULL
train_data2$Name <- NULL
train_data2$Ticket <- NULL
train_data2$Cabin <- NULL
train_data2$Child <- NULL
train_data2$Fare2 <- NULL

 # there are NA have no clue how QUEST will deal with this
train_data_quest <- train_data2[, c(2,3,4,5,6,7,8,1)]
# male = 1 female = 2
train_data_quest$Sex <- as.numeric(train_data_quest$Sex)
# embarked "" = 1, C = 2, Q = 3, S = 4
train_data_quest$Embarked <- as.numeric(train_data_quest$Embarked)

anyNA(train_data_quest$Age)
sum(is.na(train_data_quest$Age))
train_data_quest$Age <- NULL

write.table(train_data_quest, sep=",", file = "./submit/traindataquest.csv",
          row.names = FALSE, col.names = FALSE)
