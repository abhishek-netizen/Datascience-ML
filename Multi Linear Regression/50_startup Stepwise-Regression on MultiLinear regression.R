startup <- read.csv(file.choose())
View(startup) 

boxplot(startup)
attach(startup)
# Exploratory data analysis
qqnorm(startup$Profit)
qqline(startup$Profit)
plot(Profit,R.D.Spend)
plot(Profit,Administration)
plot(startup$Profit,Marketing.Spend)
plot(startup$Profit,startup$State)
hist(Profit)
hist(R.D.Spend)
hist(Marketing.Spend)
hist(State)
cor(startup$Profit,Administration) #0.2007166
cor(startup$Profit,Marketing.Spend) #0.7477657
cor(startup$Profit,R.D.Spend)# 0.9729005
unique(startup$State)
startup <- startup[-4] #Removing "State" feature
View(startup)
#Step 1:  plot the data
plot(startup$Profit~R.D.Spend)
plot(startup$Profit~Administration)
plot(startup$Profit~Marketing.Spend)

cor(startup) # correlation matrix

# The Linear Model of interest
model1 <- lm(Profit~R.D.Spend+Marketing.Spend+Administration)
summary(model1) #R-squared:  0.9507 # p-value: < 2.2e-16 
#feature R.D.Spend is the most affecting over profit
#Marketing.Spend and  Administration looks like they are less significant ti my model

model1 <- lm(Profit~R.D.Spend+Marketing.Spend+Administration)
model <- model1
df=startup
fit <- lm(model, df)
fit
summary(fit) 
#looks like R.D.Spend and  Marketing.Spend is the only variable which has statistical impact over profit

# incase if we want To test a hypothesis in statistic, we use:
#H0: No statistical impact
#H1: The predictor has a meaningful impact on y
#If the p value is lower than 0.05, it indicates the variable is statistically significant

#Adjusted R-squared: Variance explained by the model. In our model, the model explained 0.9475(94%) percent of the variance of y. 
#R squared is always between 0 and 1. The higher the better
# we can use ANOVA test to estimate the effect of each feature on the variances with the anova() function
anova(fit)
#A more conventional way to estimate the model performance is to display the residual against different measures
#we are using the plot() function to show four graphs
plot(fit)
par(mfrow=c(2,2)) #to display all 4 at once #first 2 clubs(adds) the 2 rows #next 2 club the colms
plot(fit)
#Before we begin analysis, its good to establish variations between the data with a correlation matrix. The GGally library is an extension of ggplot2
install.packages("GGally")
library("GGally")
ggscatmat(df, columns = 1: ncol(df))
#####Stepwise regression#####
install.packages("olsrr")
library("olsrr")
model <- Profit~.
fit <- lm(model, df)
test <- ols_all_subset(fit)
ols_step_both_p(fit, pent = 0.1, prem = 0.3, details = FALSE) #pent and prem are default values
#Stepwise Selection Summary                                    
#At the end, you can say the models is explained by two variables and an intercept.
#two variables are R.D.Spend and Marketing.Spend  
stp_s <-ols_step_both_p(fit, details=TRUE) #for complete detailed explanation of stepwise regression
##########################final model####################
finalmodel <- lm(startup$Profit~startup$R.D.Spend+startup$Marketing.Spend)
summary(finalmodel) #Multiple R-squared:  0.9505 p-value: < 2.2e-16
#R^2 value is 95% So Our Model is too sufficient.