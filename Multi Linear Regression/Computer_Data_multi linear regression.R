#Predict Price of the computer
computers <- read.csv(file.choose())
View(computers)
head(computers)
tail(computers)
computers <- computers[-1]
View(computers)
is.na.data.frame(computers) #check for na
na.omit(computers) #remove in case na present
install.packages("psych")
library("psych")
a <- dummy.code(computers$cd)
cd1 <- as.data.frame(a)
View(cd1) 
b <- dummy.code(computers$multi)
multi1 <- as.data.frame(b)
View(multi1)
c <- dummy.code(computers$premium)
premium1 <- as.data.frame(c)
View(premium1)

com <- computers[-6:-8] #removing cd,prem,multi
com
dummyabc <- cbind(a,b,c) #cbinding dummys
computers1 <- cbind(com,dummyabc(a,b,c)) #cbind dummys and com and store it in computers1
View(computers1)
tail(computers1)
write.csv(computers1,"C:\\Users\\hp\\Desktop\\computerfile.csv", row.names = FALSE) #write the file back to desktop
#edit the columns as we wish with the help of excel
install.packages("readxl")
library("readxl")
computerfinal <- read_excel(file.choose())
View(computerfinal)
attach(computerfinal)
df <-computerfinal[-8:-13] #try to regressing first on continuous variable
View(df)
boxplot(df)
attach(df)
plot(price,speed)
plot(price,ram)
hist(price)
hist(ram)
hist(speed)
qqnorm(price)
qqline(price)
qqnorm(speed)
qqline(speed)
cor(df)
#regressing first on continuous variable
model <- lm(price~speed+hd+ram+screen+ads+trend)
summary(model) #R-squared:0.7123 #its indicating all values here is significant
#no multicolinearity issue
#Re-chechking with the help of stepAIC.
install.packages("MASS")
library("MASS")
stepAIC(model) #AIC=71884.91 which is the only model suggested by AIC as all features are significant

#Regression by including discrete features
View(computerfinal)
attach(computerfinal)
a=cbind(cd_yes,cd_no,prem_no,prem_yes,multi_no,multi_yes)
model1 <- lm(price~speed+hd+ram+screen+ads+trend+a,data = computerfinal)
summary(model) R-squared:  0.7756
 
#diagnostic plots
install.packages("car")
library("car")
plot(model1)
# Deletion Diagnostics for identifying influential variable
influence.measures(model1)
influenceIndexPlot(model1) 
influencePlot(model1) #influencing rows are 1441 and 1701 greater than 0.5
model2 <- lm(price~speed+hd+ram+screen+ads+trend+a[-c(1441,1701),],data = computerfinal[-c(1441,1701),])
summary(model2) #R-squared:  0.7777
#accuracy of model increaesed from all the way 0.7123 to 0.7777 
#77% of variation in my independent variables explained by dependent variable
