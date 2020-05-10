install.packages("readxl")
library("readxl")
cola <- read_excel(file.choose())
View(cola)
str(cola)
#Combine levels using business method
#install.packages("rockchalk")
#library(rockchalk)
#combineLevels()

# or we can modify the dataset using excel..
#import newly modified dataset 
cola_new <- read_excel(file.choose())
View(cola_new$new)
cola_new
#creating dummy
install.packages("caret")
library("caret")
dmy <- dummyVars("~.",data = cola_new[-1])
dmy
trsf <- data.frame(predict(dmy, newdata = cola_new))
View(trsf)
#dummys are created to as 11, as i consideres 11 levels in Quarter column

#fit model
attach(trsf)
model <- lm(Sales~newA+newB+newC+newD+newE+newF+newG+newH+newI+newK,data = trsf)
summary(model)
#all the variables are significant to use in our regression, except newI and newK.
confint(model,level = 0.95)
pred <- predict(model,interval="predict")
pred
pred <- as.data.frame(pred)
View(pred)
cor(pred$fit,trsf$Sales) #0.9462238
#94% of predicted values are correlated with the actual values.
#94% of variations are explained by regression model

#improve model performance
install.packages("MASS")
library(MASS)
stepAIC(model)

#insignificant variable newk removed here in the below model, all the p values are below threshold p<0.05 
model2 <- lm(Sales ~ newA + newB + newC + newD + newE + newF + newG + newH + 
               newI,data = trsf)
summary(model2)
predc <- predict(model2,interval = "predict")
predc
predc <- as.data.frame(predc)
cor(predc$fit,trsf$Sales) #0.9453616




# Function that returns Root Mean Squared Error
rmse <- function(error)
{
  sqrt(mean(error^2))
}
#Error
#for model1
error=trsf$Sales-pred$fit
rmse(error)#312.5842
#Error
#For model 2
error=trsf$Sales-predc$fit
rmse(error) #315.0102
