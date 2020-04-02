data1 <- read.csv(file.choose())
View(data1)
colnames(data1) = c("weight_gained", "cal_cons") #rename the features
View(data1)
attach(data1)
#predict weight gained using calories consumed
# Exploratory data analysis
summary(data1)

hist(cal_cons)
hist(weight_gained)
boxplot(data1)
range(weight_gained)
range(cal_cons)
mean(weight_gained)
mean(cal_cons)
median(cal_cons)
median(weight_gained)

#dot plot
install.packages("lattice")
library("lattice")
dotplot(data1$weight_gained,main="Dot Plot of weight gain")
dotplot(data1$cal_cons,main="Dot Plot of calorie consumed")

#Scatter plot
plot(data1$weight_gained,data1$cal_cons,main="Scatter Plot", col="Dodgerblue4", 
     col.main="Dodgerblue4", col.lab="red", xlab="calorie consumed", 
     ylab="weight gained", pch=20)
#correlation
cor(data1$cal_cons,data1$weight_gained) #0.946991

#regression
reg <- lm(data1$weight_gained~data1$cal_cons,data=data1)#y~x
summary(reg) #R^2=0.8882
confint(reg,level=0.95)  
pred <- predict(reg,interval="predict")
pred <- as.data.frame(pred)
View(pred)
cor(pred$fit, data1$weight_gained) #0.946991
#p-value: 2.856e-07
### hence r(corelation co efficient) value is 0.94 , our model is strongly predict the weight gained using calories consuming
#below i tried to increase model accuracy but this one is better and gives better result.


#to increse R sq
# transform the variables to check whether the predicted values are better
reg_sqrt <- lm(data1$weight_gained~sqrt(data1$cal_cons),data=data1) #y~x
summary(reg_sqrt) #0.8448
confint(reg_sqrt,level=0.95)
predict(reg_sqrt,interval="predict")
pred1 <- predict(reg_sqrt,interval="predict")
pred1
pred1 <- as.data.frame(pred1)
cor(pred1$fit, data1$weight_gained) #0.9255962
#decresing  R square
#rejecting this model
