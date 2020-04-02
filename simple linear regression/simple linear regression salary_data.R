#Build a prediction model for Salary_hike
data1 <- read.csv(file.choose())
View(data1)
#exploratory data analysis
hist(data1$YearsExperience)
hist(data1$Salary)
attach(data1)
boxplot(data1)
plot(data1$YearsExperience,data1$Salary)
#by scatter plot as num of years of exp increases salary scale also increases
cor(data1$Salary,data1$YearsExperience) #0.9782416
#regression
reg <- lm(data1$Salary~data1$YearsExperience,data=data1)
summary(reg) #R-squared:  0.957 #p-value: < 2.2e-16
confint(reg,level=0.95)
pred <- predict(reg,interval="predict")
pred
pred <- as.data.frame(pred)
View(pred)
cor(pred$fit,data1$Salary) #0.9782416

