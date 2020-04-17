salary_train <- read.csv(file.choose())
View(salary_train)
a <- salary_train$Salary
a
str(salary_train$Salary)

table(salary_train$Salary) # <=50K(22653) and >50K(7508)
#build a corpus using a text mining package (tm)
#install.packages(tm)
library(tm)
salary_train_corpus <- VCorpus(VectorSource(salary_train$Salary))
#clean the corpus using functions tm_map()
corpus_clean <- tm_map(salary_train_corpus,content_transformer(tolower))
corpus_clean <- tm_map(corpus_clean,removeNumbers)
corpus_clean <- tm_map(corpus_clean,removeWords,stopwords())
corpus_clean <- tm_map(corpus_clean,removePunctuation)
corpus_clean <- tm_map(corpus_clean,stripWhitespace)
#create a document term matrix
salaryt_train_dtm <- DocumentTermMatrix(corpus_clean)
salaryt_train_dtm

### importing testing datset ###
salary_test <- read.csv(file.choose())
View(salary_test)
table(salary_test$Salary) # <=50K(11360) and  >50K(3700)
salary_test_corpus <- VCorpus(VectorSource(salary_test$Salary))
#clean the corpus using functions tm_map()
corpus_clean1 <- tm_map(salary_test_corpus,content_transformer(tolower))
corpus_clean1 <- tm_map(corpus_clean,removeNumbers)
corpus_clean1 <- tm_map(corpus_clean,removeWords,stopwords())
corpus_clean1 <- tm_map(corpus_clean,removePunctuation)
corpus_clean1 <- tm_map(corpus_clean,stripWhitespace)
b <- salary_test
b
#create a document term matrix
salary_test_dtm <- DocumentTermMatrix(corpus_clean1)
salary_test_dtm
#convert the counts to factor
#custom function : if a word is used more than 0 times then mention 1 else mention 0
convert_counts <- function(x){
  x <- ifelse(x>0,1,0)  
  x <- factor(x,levels=c(0,1),labels = c("NO","YES"))
}
convert_counts
#apply convert counts() to columns of traina and test data
#margin 2 for column and margin 1 for row
salary_train2 <- apply(salary_train,MARGIN = 2,convert_counts)
salary_test2 <- apply(salary_test,MARGIN = 2,convert_counts)

###  Training a model(Naive Bayes) on the data  ####
install.packages("e1071")
library("e1071")
classifier <- naiveBayes(salary_train2,salary_train$Salary)
classifier

##  Evaluating model performance ####
pred <-predict(classifier,salary_test2)
View(pred)
table(pred) #<=50K(14228) and  >50K(832)
prop.table(table(pred))#<=50K(0.94475432) and >50K(0.05524568)
#94% of the people will recieve salary below or equal to 50k and 5% of people will recieve salary more
#than that of 50k.

