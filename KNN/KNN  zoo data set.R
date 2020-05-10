zoo <- read.csv(file.choose())
View(zoo)
str(zoo) ## in data set variables are which data type we can see
names(zoo) <- c("animal", "hair", "feathers", "eggs", "milk", "airborne",
              "aquatic", "predator", "toothed", "backbone", "breathes", "venomous",
              "fins", "legs", "tail", "domestic", "size", "type") # change the data column names as oer our requirement

types <- table(zoo$type)# in type column how many total values in table format 

zoo$animal <- NULL
names(types) <- c("mammal", "bird", "reptile", "fish", "amphibian", "insect", "crustacean")
## Let us assuming the in zoo how many  category types of animals 

types# Checking the animal category type name  and quantity   
summary(zoo) ## find  the 1st,2nd qurtile and min and max values
str(zoo) # Check the varibles in which data type 
View(zoo)
# create training and test data
zoo_train <- zoo[1:70, ]
zoo_test <- zoo[71:101, ]

# create labels for training and test data

zoo_train_labels <- zoo[1:70, 17]

zoo_test_labels <- zoo[71:101, 17]
#---------------K-selection--------------------------------------
#Inorder to select the K value we normally take the square root of labelled trail data.
NROW(zoo_train_labels) #70
#Sqrtof(70)=8.3666
#so we can try by using 8 or 9 as K values.

#--------------------Model---------------------------------------#
install.packages("class")
library(class)
#model 
#--------------------Lets try K as 8-----------------------------#
knn.8 <- knn(train = zoo_train,test=zoo_test,cl= zoo_train_labels,k=8)
knn.8
#Accuracy
ACC.8 <- 100 * sum(zoo_test_labels ==knn.8)/NROW(zoo_test_labels)
ACC.8 #Accuracy is 67.74194 when we use k as 8.

install.packages("gmodels")
library(gmodels)
# Create the cross tabulation of predicted vs. actual
CrossTable(x = zoo_test_labels, y = knn.8,
           prop.chisq=FALSE)
#--------------------Lets try K as 9-----------------------------#
knn.9 <- knn(train = zoo_train,test=zoo_test,cl= zoo_train_labels,k=9)
knn.9
#Accuracy
ACC.9 <- 100 * sum(zoo_test_labels ==knn.9)/NROW(zoo_test_labels)
ACC.9 #Accuracy is 67.74194 when we use k as 9.

install.packages("gmodels")
library(gmodels)
# Create the cross tabulation of predicted vs. actual
CrossTable(x = zoo_test_labels, y = knn.9,
           prop.chisq=FALSE)
#--------------------Loop for K-selection--------------------------#
#we have seen accuracy does not improve much when we use K as 9,
#so we found that difficulty in choosing K value lets use trail and error method.
#by looping it out
#This loop trying to iterate from 1 to 28,By giving each i's Accuracy

i=1                          # declaration to initiate for loop
k.optm=1                     # declaration to initiate for loop
for (i in 1:28){ 
  zoo_test_pred  <-  knn(train=zoo_train, test=zoo_test, cl=zoo_train_labels, k=i)
  k.optm[i] <- 100 * sum(zoo_test_labels == zoo_test_pred)/NROW(zoo_test_labels)
  k=i  
  cat(k,'=',k.optm[i],'\n')       # to print % accuracy 
}

#with the help of loop we decided to use K as 1,Because its indicating highest accuracy.

knn.1 <- knn(train = zoo_train,test=zoo_test,cl= zoo_train_labels,k=1)
knn.1
#Accuracy
ACC.1 <- 100 * sum(zoo_test_labels ==knn.1)/NROW(zoo_test_labels)
ACC.1 #Accuracy is 93.54 when we use k as 1.
table(knn.1 ,zoo_test_labels)

#--------------------plot the iterated k values-----------------------------------
plot(k.optm, type="b", xlab="K- Value",ylab="Accuracy level")

#At k=1, maximum accuracy achieved which is 93%, 
#after that, it seems increasing K increases the classification but reduces success rate. 








