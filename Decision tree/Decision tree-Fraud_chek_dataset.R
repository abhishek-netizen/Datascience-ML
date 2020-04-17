#Use decision trees to prepare a model on fraud data 
#treating those who have taxable_income <= 30000 as "Risky" and others are "Good"


data <- read.csv(file.choose())
View(data)
data <- na.omit(data)
data <- na.omit(data)
View(data)
#changing numerical values to categorical
Targ <- ifelse(data$Taxable.Income<=30000,"Risky","Good")
View(Targ)
#from now on original datset taxable column will be categorical
data$Taxable.Income <- Targ
View(data)
#installing required packages
#install.packages("caret")
library(caret) #for data partition
#install.packages("C50")
library("C50")
#create data partion
inTraininglocal <- createDataPartition(data$Taxable.Income,p=.75, list=F)
training <- data[inTraininglocal,]
testing <- data[-inTraininglocal,]
View(training)
View(testing)
str(training)
#### model-building ###
training$Taxable.Income <- as.factor(training$Taxable.Income)
model <- C5.0(training$Taxable.Income~.,data=training,trails=1000)
summary(model)
###predicting the model###
pred <- predict.C5.0(model,testing[-3])
View(pred)
a <- table(testing$Taxable.Income,pred)
a
#Accuracy of the model
sum(diag(a)/sum(a)*100) #79.33333% accuracy 
plot(model)
#######Bagging##########
acc<-c()
for(i in 1:100)
{
  print(i)
  inTraininglocal1<-createDataPartition(data$Taxable.Income,p=.75,list=F)
  training1<-data[inTraininglocal1,]
  testing1<-data[-inTraininglocal1,]
  training1$Taxable.Income<- as.factor(training1$Taxable.Income)
  fittree<-C5.0(training1$Taxable.Income~.,data=training1)
  pred<-predict.C5.0(fittree,testing[-3])
  table(testing1$Taxable.Income,pred)
  acc<-c(acc,sum(diag(a))/sum(a))
}
summary(acc)
acc
