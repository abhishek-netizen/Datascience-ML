data <- read.csv(file.choose())
View(data)
mean(data$Sales) #7.49
Targ_var <- ifelse(data$Sales<10,"no","yes")
data$Sales <- Targ_var #converting numerical value in to yes or no of data$sales
View(data)
# Data partion for model building and testing..
install.packages("caret")
library("caret")
inTraininglocal <- createDataPartition(data$Sales,p=.75, list=F) 
training <- data[inTraininglocal,]
View(training)
testing <- data[-inTraininglocal,]
View(testing)
#model building
install.packages("randomForest")
library("randomForest")
training$Sales <- as.factor(training$Sales)
fit.forest <- randomForest(training$Sales~.,data = training,na.action=na.roughfix,importance=TRUE, ntree=1000)
summary(fit.forest)
# Training accuracy 
mean(training$Sales==predict(fit.forest,training))# 100% accuracy 
# Prediction of train and test data
pred_train <- predict(fit.forest,training) #pred of training
pred_train
mean(pred_train==training$Sales) #100% of accuracy
pred_test <- predict(fit.forest,testing) #pred of testing
pred_test
mean(pred_test==testing$Sales) #0.8888889% of accuracy
# Confusion Matrix
confusionMatrix(training$Sales, pred_train) #on training
testing$Sales <- as.factor(testing$Sales)
confusionMatrix(testing$Sales, pred_test) #on testing
# Visualization 
plot(fit.forest,lwd=2)
legend("topright", colnames(fit.forest$err.rate),col=1:4,cex=0.8,fill=1:4)



#col:the color of points or lines appearing in the legend.
#cex:character expansion factor relative to current par("cex"). Used for text, and provides the default for pt.cex
#pt.cex	expansion factor(s) for the points.
