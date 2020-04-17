data1 <- read.csv(file.choose())
View(data1)
data <- na.omit(data1)
View(data)
Targ <- ifelse(data$Taxable.Income<=30000,"Risky","Good")
data$Taxable.Income <- Targ
View(data)
# Data partion for model building and testing..
install.packages("caret")
library("caret")
inTraininglocal <- createDataPartition(data$Taxable.Income,p=.75, list=F)
training <- data[inTraininglocal,]
View(training)
testing <- data[-inTraininglocal,]
View(testing)
#model building
install.packages("randomForest")
library("randomForest")
training$Taxable.Income <- as.factor(training$Taxable.Income)
fit.forest <- randomForest(training$Taxable.Income~.,data = training,na.action=na.roughfix,importance=TRUE, ntree=1000)
summary(fit.forest)
# Training accuracy 
mean(training$Taxable.Income==predict(fit.forest,training))# 91.33% Training accuracy 
# Prediction of train and test data
pred_train <- predict(fit.forest,training) #pred of training
pred_train
mean(pred_train==training$Taxable.Income) #91.33% of accuracy
pred_test <- predict(fit.forest,testing) #pred of testing
pred_test
mean(pred_test==training$Taxable.Income) #79.15% of accuracy

table(training$Taxable.Income,pred_train)
table(testing$Taxable.Income,pred_test)
# Confusion Matrix
confusionMatrix(training$Taxable.Income, pred_train) #on training
testing$Taxable.Income <- as.factor(testing$Taxable.Income)
confusionMatrix(testing$Taxable.Income, pred_test) #on testing
# Visualization 
plot(fit.forest,lwd=2)
legend("topright", colnames(fit.forest$err.rate),col=1:4,cex=0.8,fill=1:4)