tayota <- read.csv(file.choose())
View(tayota)
unique(tayota)
attach(tayota)
Corolla<-tayota[c("Price","Age_08_04","KM","HP","cc","Doors","Gears","Quarterly_Tax","Weight")]
corolla <- as.data.frame(Corolla)
View(corolla)
#basic visualization
boxplot(corolla)
attach(corolla)
hist(Price)
hist(HP)
#step 1:: scatter plot
plot(Age_08_04,Price)
plot(KM,Price)
plot(HP,Price)
pairs(corolla) #scatter plot applied to complete dataset

#finding correlation matrix
cor(corolla)
#price and age of the vihicle strongly negatively correlated
#price and KM of the vihicle moderate negatively correlated
#price and weight of the vihicle moderate positevely correlated
#weight and quarterly tax are moderate positively correlated

#Partial correlation to avoid spillover
library(corpcor)
cor2pcor(cor(corolla))
#linear regression
model <- lm(Price~Age_08_04+KM+HP+cc+Doors+Gears+Quarterly_Tax+Weight)
summary(model) #R-squared:  0.8638,
#model suggesting all are significant except "cc" and "doors"
#"cc" and "doors" looks like colinearity exist in them, p values greater than the threshold


install.packages("MASS")
library("MASS")
stepAIC(model) #lower the AIC better the model
modelAIC <- lm(Price ~ Age_08_04 + KM + HP + Gears + Quarterly_Tax + Weight) #model suggested by function stepAIC. AIC=20691.7
summary(modelAIC) #R-squared:  0.8636
#86.36%of accuracy by modelAIC

#checking for influencial record
install.packages("car")
library("car")
influence.measures(modelAIC)
# ploting influential measures
influenceIndexPlot(modelAIC)
influencePlot(modelAIC)
#with the help of cooks distance
#the rows 222 and 961 are influencing, remove the influencing rows and try to recreate the model
modelnew <- lm(Price ~ Age_08_04 + KM + HP + Gears + Quarterly_Tax + Weight,data =corolla[-c(222,961),])
summary(modelnew) #R-squared:  0.8727
#model accuracy increased from 0.8636 to 0.8727 
#87.27% of variation in my independent variables are explained by my dependent variable
#with the hel of "modelnew
#which is good
