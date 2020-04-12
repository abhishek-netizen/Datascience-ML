data <- read.csv(file.choose())
View(data)
data <- na.omit(data)
zoo <- data #removing animal name column 'categorical data'
View(zoo)
head(zoo,3)
zoo1 <- zoo[-1]
View(zoo1)
str(zoo1) 

#Generate a random number that is 90% of the total number of rows in dataset.
ran <- sample(1:nrow(zoo1),0.9*nrow(zoo))
#the normalization function is created
nor <- function(x){(x-min(x))/max(x)-min(x)}


#Run nomalization on 13 coulumns of dataset because they are the predictors
zoo1_norm <- as.data.frame(lapply(zoo1[,c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17)],nor))



#extract training set

zoo1_train <- zoo1_norm[ran,] #ran is nothing but sampling
#extract testing set
zoo1_test <- zoo1_norm[-ran,] #excluding train samples using '-ran'
#extract 1st column of train dataset because it will be used as 'cl' argument in knn function.

zoo1_target_category <- (zoo1[ran,1])
is.factor(zoo1_target_category)
#extract 1st column in test dataset to measure the accuracy
zoo1_test_category <- (zoo1[-ran,1])

#install the package class
install.packages("class")
library(class)
#knn function
pr <- knn(zoo1_train,zoo1_test,cl=zoo1_target_category,k=4)
View(pr)
#create confusion matrix
tab <- table(pr,zoo1_test_category)
View(tab)
#accuracy of the model
accuracy <- function(x){sum(diag(x)/(sum(rowSums(x)))) * 100}
accuracy(tab)


install.packages("gmodels")
library(gmodels)
CrossTable(pr[1:4],zoo1_test_category[1:4],prop.chisq = FALSE,prop.t = FALSE,prop.r = FALSE,dnn = c('predicted','actual'))
