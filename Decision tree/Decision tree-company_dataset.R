data <- read.csv(file.choose()) #company_dataset
View(data)
data <- na.omit(data) #remove na's if any
str(data)
summary(data)
install.packages("caret") #to help datapartition
library("caret")
#first thing is we cannot apply C5.0 Decision tree model on this data
#because they are numerical variable(egs:sales variable), we have to convert them into categorical
Targ_condn <- ifelse(data$Sales<10,"no","yes")
data$Sales <- Targ_condn #replacing sales colmn in the dataset by Targe_cond(yes or no)
View(data)
# Data partion for model building and testing
inTraininglocal <- createDataPartition(data$Sales,p=.75, list=F)
training <- data[inTraininglocal,]
testing <- data[-inTraininglocal,]
View(training)
View(testing)
str(training)
#model building
install.packages("C50")
library("C50")
training$Sales <- as.factor(training$Sales) #factorising sales which was as character before
model <- C5.0(training$Sales~.,data = training,trails=1000)
summary(model)
#predicting the model
attach(training)
pred <- predict.C5.0(model,testing[,-1])
View(pred)
a <- table(testing$Sales,pred)
a
#accuracy
sum(diag(a)/sum(a)*100) #model accuracy is #84.84848%
plot(model)
################ Bagging ###############
acc<-c()
for(i in 1:100)
{
  print(i)
  inTraininglocal1<-createDataPartition(data$Sales,p=.75,list=F)
  training1<-data[inTraininglocal1,]
  testing1<-data[-inTraininglocal1,]
  training1$Sales <- as.factor(training1$Sales)
  fittree<-C5.0(training1$Sales~.,data=training1)
  pred<-predict.C5.0(fittree,testing[-1])
  table(testing1$Sales,pred)
  acc<-c(acc,sum(diag(a))/sum(a))
}
summary(acc)
acc


