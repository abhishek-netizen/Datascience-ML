glass <- read.csv(file.choose())
View(glass)
#scale
standard.features <- scale(glass[,1:9])
standard.features #note Target variable not included
data <- cbind(standard.features,glass[10])
data
anyNA(data) #FALSE
head(data)
install.packages('corrplot')
library(corrplot)
corrplot(cor(data))
#train test split
install.packages('caTools')
library(caTools)
set.seed(123)
sample <- sample.split(data$Type,SplitRatio = 0.70)

train <- subset(data,sample==TRUE)

test <- subset(data,sample==FALSE)


install.packages('class') 
library(class
predicted.type <- knn(train[1:9],test[1:9],train$Type,k=1)
#Accuracy and Error in prediction
Accuracy <- mean(predicted.type==test$Type)
error <- mean(predicted.type!=test$Type)

#Confusion Matrix
confusionMatrix(predicted.type,test$Type)
#--------------Loop----------------------------
predicted.type <- NULL
Accuracy.rate <- NULL
error.rate <- NULL

for (i in 1:10) {
  predicted.type <- knn(train[1:9],test[1:9],train$Type,k=i)
  Accuracy.rate[i] <- mean(predicted.type==test$Type)
  error.rate[i] <- mean(predicted.type!=test$Type)
  
}
knn.accuracy <- as.data.frame(cbind(k=1:10,Accuracy.type =Accuracy.rate))
knn.accuracy
knn.error <- as.data.frame(cbind(k=1:10,error.type =error.rate))
knn.error
observe <- cbind(knn.accuracy,knn.error[-1])
observe
#----------by using plot- error--------------------------
install.packages('ggplot2')
library(ggplot2)

ggplot(knn.error,aes(k,error.type))+ 
  geom_point()+ 
  geom_line() + 
  scale_x_continuous(breaks=1:10)+ 
  theme_bw() +
  xlab("Value of K") +
  ylab('Error')
#plot reveals that error is lowest when k=3 and then jumps.

#-----------------Final------------------------------------
predicted.type <- knn(train[1:9],test[1:9],train$Type,k=3)
#Error in prediction
accuracy <- mean(predicted.type==test$Type)
accuracy #0.6769231
error <- mean(predicted.type!=test$Type)
error #0.3230769
a <- table(predicted.type,test$Type)
a
prop.table(a)

#The Above Model gave us an accuracy of 67.69231 %.




