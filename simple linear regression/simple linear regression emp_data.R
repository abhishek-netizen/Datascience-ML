#Build a prediction model for Churn_out_rate 
emp_data <- read.csv(file.choose())
View(emp_data)
attach(emp_data)
#exploratory data analysis
summary(emp_data)
hist(emp_data$Salary_hike)
hist(emp_data$Churn_out_rate)
boxplot(emp_data)
qqnorm(emp_data$Salary_hike)
qqline(emp_data$Salary_hike)
mean(emp_data$Salary_hike)
mean(emp_data$Churn_out_rate)
#scatter plot
plot(emp_data$Salary_hike,emp_data$Churn_out_rate,main="scatterplot",col="red",col.main="red",
     col.lab="red",xlab="Salary_hike",ylab="Churn_out_rate",pch=20) #Seeing Scatter Plot we Concluded that direction is negative,Strength is strong
#correlation
cor(emp_data$Salary_hike,emp_data$Churn_out_rate)
#regression
reg <- lm(emp_data$Churn_out_rate~emp_data$Salary_hike,data=emp_data)
summary(reg) #R-squared:  0.8312 #p-value: 0.0002386
confint(reg,level=0.95)
pred <- predict(reg,interval="predict")
pred
pred <- as.data.frame(pred)
View(pred)
cor(pred$fit,emp_data$Churn_out_rate) #0.9117216

### Transform The data using Log Function ###
reg2 <- lm(emp_data$Churn_out_rate~log(emp_data$Salary_hike),data=emp_data)
summary(reg2) #R-squared:  0.8486 p-value: 0.0001532 #increase in R sq value from 0.8312 to 0.8486
confint(reg,level=0.95)
pred2 <- predict(reg2,interval="predict")
pred2
pred2 <- as.data.frame(pred)
View(pred2)
cor(pred2$fit,emp_data$Churn_out_rate) #0.9212077
#as the salary hike goes on increasing churn out rate goes decreasing
