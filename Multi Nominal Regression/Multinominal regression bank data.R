install.packages("mlogit")
library("mlogit")
install.packages("nnet")
library("nnet")
bank <- read.csv(file.choose())
View(bank)
levels(bank$job) #checking the levels of each variables
levels(bank$marital)
levels(bank$education)
levels(bank$default)
levels(bank$housing)
levels(bank$loan)
levels(bank$contact)
levels(bank$month)
levels(bank$poutcome)
levels(bank$y)
#else we can use function to check unique values as below
sapply(bank,function(x) length(unique(x)))

tail(bank)
table(bank$y) #table to see target variable
str(bank) #see the type of variables factor or number
data.raw=bank
dim(data.raw)
length(data.raw$y) #45211 entries

data.raw[data.raw==""] <- NA
#to check for missing values using sapply() function
sapply(data.raw,function(x) sum(is.na(x)))
colSums((is.na(data.raw))) #this command also do the same as sapply
data <- na.omit(data.raw)
View(data)
#To check correlation i wll convert all the categorical to factor
# in to the indicator variable using dummies package
install.packages("dummies")
library("dummies")
View(data)
data1=data[1:4]
data2=data[6:8]
data3=data[10]
data4=data[15]
data5=data[16]
#selecting only categorical variable
dats_category <- cbind.data.frame(data1,data2,data3,data4,data5)
View(dats_category)
#selecting only continous variable
data_con <- data[,-c(1,2,3,4,6,7,8,10,15,16)]
View(data_con)
#combining both
data_final <- cbind(data_con,dats_category)
View(data_final)
#applying generalized logistic model on both categorical and continous variable
model <- glm(data_final$y~.,family = binomial(link = 'logit'),data = data_final)
summary(model)
#predicting  with actual values
prob <- predict(model,type = c("response"),data_final)
prob
confusion <- table(prob>0.5,data$y)
confusion
accuracy <- sum(diag(confusion)/sum(confusion))
accuracy #0.9018159
#with the help of ROC curve
#Roc Curve
install.packages("ROCR")
library(ROCR)
rocpred <- prediction(prob,data$y)
rocperf <- performance(rocpred,'tpr','fpr')
plot(rocperf)

#########FINAL CONFUSION MATRIX ###########
(table(actualvalue=data_final$y,predictedvalue=prob>0.5))
