startup <- read.csv(file.choose())
View(startup)
head(startup)
levels(startup$State)
install.packages("psych")
library("psych")
new <- dummy.code(startup$State)
new1 <- as.data.frame(new)
View(new1)
pairs(new1) #dummy has no relative

data <- startup[-4] #removing categorical variable "state"
View(data)
#EDA
attach(data)
boxplot(data)
hist(Profit)
str(data) #all are numeric
summary(data)
# Explore the data with the help of plots
pairs(data) #scatterplot,
cor(data) #Finding the Correlation profit is strongly correlated with R.D.Spend and with marketing spend
# ///////The Linear Model of interest 
model <- lm(Profit~R.D.Spend+Marketing.Spend+Administration,data = data)
summary(model) #Multiple R-squared:  0.9507,	Adjusted R-squared:  0.9475, p-value: < 2.2e-16
#here R.D.Spend looks like significant to my target variable profit
#P value for administration & Marketing.spend more Than 0.05

#checking for multicolinearity problem
model.col <- lm(Profit~Marketing.Spend)
summary(model.col)
model.col2 <- lm(Profit~Administration) #Administartion has no influence over profit
summary(model.col2)
#another method to check multicolinearity is AIC
#lesser AIC better the model
#Step:  AIC=915.18     Profit ~ R.D.Spend + Marketing.Spend
install.packages("MASS")
library("MASS")
stepAIC(model) #its suggesting >> #Step:  AIC=915.18     Profit ~ R.D.Spend + Marketing.Spend
#lets create a linear model based on the information given by  AIC
model_suggest <- lm(Profit ~ R.D.Spend + Marketing.Spend,data = data)
summary(model_suggest) #Multiple R-squared:  0.9505,	Adjusted R-squared:  0.9483 

#instead of removing the complete variable lets try create a better model by removing inflation values
#checking by using Variance inflation factor (VIF)
install.packages("car")
library("car")
vif(model) #wtf its suggesting to remove R.D.spend ??? 
#plots
library(car)
influence.measures(model)
influenceIndexPlot(model)
influencePlot(model)
## The Influence rows are 50 & 49 visualized with the help of cooks distance
## Regression after deleting the 49 and 50th observation(rows)
#########################final model############################################
model_clean <- lm(Profit~R.D.Spend+Marketing.Spend+Administration,data =data[-c(50,49),])
summary(model_clean) #increased R sq #Multiple R-squared:  0.9627,	Adjusted R-squared:  0.9601
# we create a model(model_clean) such that the 96% of variations in the independent variables is explained by  dependent variable
#F-test tells us variation explained by the regression line to the residual variation.