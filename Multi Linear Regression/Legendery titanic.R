install.packages("titanic")
library(titanic)
#sibsp- number of sibling or spouses abroad
#parch-num of parents or children abroad
#embarked: c=cherbourg, q=queenstown s= southampton
data.raw=titanic_train
data.raw#training the titanic data set
dim(data.raw)#shows dimension
View(titanic_train)
length(data.raw$Pclass)#to check the leanth of anyone row
data.raw[data.raw==""] <- NA #just check any blanks if its there fill that blank by NA
sapply(data.raw,function(x) sum(is.na(x)))
colSums(is.na(data.raw))
#just go and check all the colmns and count the NA 
#sapply is just like applying the some kind of function to the dataset
sapply(data.raw, function(x) length(unique(x)))#sex only 2, 89 different age category persons like that....
#some basic understanding of the datasets
overall_survival_rate=sum(data.raw$Survived==1)/length(data.raw$Survived)
cat("Fraction of people who survived=", format(overall_survival_rate,digits = 3))
male_survival_rate = sum((data.raw$Survived == 1) & (data.raw$Sex == "male"))/sum(data.raw$Sex == "male")
cat("Fraction of men who survivied = ", format(male_survival_rate, digits = 3))
female_survival_rate = sum((data.raw$Survived == 1) & (data.raw$Sex == "female"))/sum(data.raw$Sex == "female")
cat("Fraction of women who survivied = ", format(female_survival_rate, digits = 3))
class1_survival_rate = sum((data.raw$Survived == 1) & (data.raw$Pclass == 1))/sum(data.raw$Pclass == 1)
cat("Fraction of 1st class passengers who survivied = ", format(class1_survival_rate, digits = 3))
class2_survival_rate = sum((data.raw$Survived == 1) & (data.raw$Pclass == 2))/sum(data.raw$Pclass == 2)
cat("Fraction of 2nd class passengers who survivied = ", format(class2_survival_rate, digits = 3))
class3_survival_rate = sum((data.raw$Survived == 1) & (data.raw$Pclass == 3))/sum(data.raw$Pclass == 3)
cat("Fraction of 3rd class passengers who survivied = ", format(class3_survival_rate, digits = 3))
#here is another way of looking at a subset of the data
data.T <- na.omit(subset(data.raw,select = c(2,3,5)))#keep only survived ,plass, and sex
table(data.T)
prop.table(table(data.raw$Survived))
prop.table(table(data.raw$Sex))
prop.table(table(data.raw$Pclass))
#lets drop some column that we are not going to use:
#1=passengerID, 4=Name 9=ticket 11=cabin
data.new <- subset(data.raw,select=c(2,3,5,6,7,8,10,12))
View(data.new)
#to check for correlation, i will convert the factors(male,female, for example)
#in to indicator variable using the "dummies" package
install.packages("dummies")
library(dummies)
data.indicator=subset(data.new,select = c(1:7))
data.indicator$Sex=dummy(data.new$Sex)
View(data.indicator)#sex turned in to 0's and 1's
cor(data.indicator)#corelation between 1 to 7
#to see how the factor will be dummified(Turned in to indicators) using R
is.factor(data.new$Sex) #is.factor is a factor function so its retur false as output
contrasts(factor(data.new$Sex))#female=0, male=1
levels(factor(data.new$Embarked))
contrasts(factor(data.new$Embarked))
#  Q S
#C 0 0
#Q 1 0
#S 0 1
data.small <- na.omit(subset(data.new,select = c(1,2,3,4,5))) #doubt ???
model <- glm(Survived~.,family =binomial(link = 'logit'),data=data.new)
summary(model)
confint(model)#to give confidence interval
plot(model)# 4 plots
data.small <- na.omit(subset(data.new,select = c(1,2,3,4,5))) #??? why 1,2,3,4
model <- glm(Survived~.,family =binomial(link = 'logit'),data=data.small)
summary(model)
#as we are not good at plots so........
#so another way to avoid plots and see predicted to actual is.
y=data.small$Survived - trunc(2*model$fitted)#actual-predicted
hits=sum(y==0)
hitratio=hits/length(y)
hitratio
#last thing to do inlogistic regression lets exponent the model coefficients
exp(coef(model)) #chances of survivals
#look out odds ratio by taking confidence interval as 95%(default evry prob)
exp(cbind(oddsratio=coef(model),confint(model)))
