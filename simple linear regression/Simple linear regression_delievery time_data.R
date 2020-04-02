#Predict delivery time using sorting time 
data1 <- read.csv(file.choose())
View(data1)
attach(data1)
#exploratory data analysis

summary(data1)
hist(data1$Delivery.Time)
hist(data1$Sorting.Time)
boxplot(data1)
mean(data1$Delivery.Time)
mean(data1$Sorting.Time)
qqnorm(data1$Sorting.Time)
qqnorm(data1$Delivery.Time)
#scatter plot
plot(data1$Sorting.Time,data1$Sorting.Time,main="scatterplot",col="red",col.main="red",
     col.lab="red",xlab="Sorting.Time",ylab="Delivery.Time",pch=20)
#correlation
cor(Sorting.Time,Delivery.Time)#0.8259973

#regression
reg <- lm(data1$Delivery.Time~data1$Sorting.Time,data=data1)#y~x
summary(reg) #Multiple R-squared:0.6823
#p-value: 3.983e-06<0.5
confint(reg,level=0.95)
pred <- predict(reg,interval="predict")
pred
pred <- as.data.frame(pred)
View(pred)
cor(pred$fit,data1$Delivery.Time) #0.8259973



