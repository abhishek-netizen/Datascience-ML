#Output variable (desired target):
  #y - has the client subscribed a term deposit? (binary: "yes","no")
bank <- read.csv(file.choose())
View(bank)
bank <- na.omit(bank)
attach(bank)
install.packages("nnet")
library("nnet")
install.packages("caret")
library("caret")
install.packages("dplyr")
library("dplyr")
unique(bank$y)
table(bank$y)
#convert categorical variables  to numeric variables
#create dummys
#the dummyVars will transform all characters and factors columns 
#(NOTE: the function never transforms numeric columns) and return the entire data set
dmy <- dummyVars(" ~ .", data = bank,fullRank = T)
dmy #16 variables, 10 factors
transformed <- data.frame(predict(dmy, newdata =bank))
View(transformed)
attach(transformed)
training.samples <- transformed$y.yes %>% 
  createDataPartition(p = 0.8, list = FALSE)
train.data  <- transformed[training.samples, ]
test.data <- transformed[-training.samples, ]
# Fit the model
model <- nnet::multinom(y.yes ~., data = train.data)
summary(model) #AIC: 17296.09 Residual Deviance: 17212.09 
# Make predictions
predicted.subc <- model %>% predict(test.data)
head(predicted.subc)
table(predicted.subc)
# Model accuracy
mean(predicted.subc == test.data$y.yes) #Model accuracy 0.9023446
a=mean(predicted.subc == test.data$y.yes)
b<-(1-a)
#client-Not-Subs-To-TermDeposit #0.09765539

---------------------------------------------------------------------------
  

