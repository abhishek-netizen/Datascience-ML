#Build a naive Bayes model on the data set for classifying the ham(another word for not spam) and spam
data <- read.csv(file.choose())
View(data)
data$type <- as.factor(data$type)
data$type
str(data$type) #in factors
str(data$text) #in factors
table(data$type) 
#ham spam 
#4812  747 
#build a corpus using a text mining package (tm)
install.packages("tm")
library("tm")
data_corpus <- VCorpus(VectorSource(data$type))
#clean the corpus using functions tm_map()
corpus_clean <- tm_map(data_corpus,content_transformer(tolower))
corpus_clean <- tm_map(corpus_clean,removeNumbers)
corpus_clean <- tm_map(corpus_clean,removeWords,stopwords())
corpus_clean <- tm_map(corpus_clean,removePunctuation)
corpus_clean <- tm_map(corpus_clean,stripWhitespace)
#create a document term matrix
data_dtm <- DocumentTermMatrix(corpus_clean)
data_dtm

#create trining and testing dataset
data_raw_train <- data[1:4169,]
data_raw_test <- data[4170:5559, ]
#creating training and testing on documengt term matrix
data_dtm_train <- data_dtm[1:4169,]
data_dtm_test <- data_dtm[4170:5559,]
#creating training and testing on corpus clean
data_corpus_train <- corpus_clean[1:4169]
data_corpus_test <- corpus_clean[4170:5559]

#checkout the propotion of spam is similar?
prop.table(table(data_raw_train$type))#ham(0.8647158) spam(0.1352842)
prop.table(table(data_raw_test$type))#ham(0.8683453)  spam(0.1316547)
#indicator feature for future words
#dictionary of words used more than that of 5 times
data_dict <- findFreqTerms(data_dtm_train,5)
data_dict

data_train <- DocumentTermMatrix(data_corpus_train,list(dictionary=data_dict))
data_test <- DocumentTermMatrix(data_corpus_test,list(dictionary=data_dict))
data_train                                
data_train
#convert the counts to factor
#custom function : if a word is used more than 0 times then mention 1 else mention 0
convert_counts <- function(x){
  x <- ifelse(x>0,1,0)  
  x <- factor(x,levels=c(0,1),labels = c("NO","YES"))
}
convert_counts
#apply convert counts() to columns of traina and test data
#margin 2 for column and margin 1 for row
data_train <- apply(data_train,MARGIN = 2,convert_counts)
data_test <- apply(data_test,MARGIN = 2,convert_counts)
str(data_train)
str(data_test)
View(data_train)
View(data_test)



###  Training a model(Naive Bayes) on the data  ####
install.packages("e1071")
library("e1071")
data_classifier <-naiveBayes(data_train,data_raw_train$type)
data_classifier #ham(0.8647158) spam(0.1352842)
##  Evaluating model performance ####
data_test_pred <- predict(data_classifier,data_test)
data_test_pred
table(data_test_pred) #ham(1207) spam(183)
prop.table(table(data_test_pred)) #ham(0.8683453) spam(0.1316547)

library(gmodels)
CrossTable(data_test_pred, data_raw_test$type,
           prop.chisq = FALSE, prop.t = FALSE, prop.r = FALSE,
           dnn = c('predicted', 'actual'))
############## using laplace in naiveBayes algo################
data_classifier2 <- naiveBayes(data_train, data_raw_train$type, laplace = 1)
data_test_pred2 <- predict(data_classifier2, data_test)

CrossTable(data_test_pred2, data_raw_test$type,
           prop.chisq = FALSE, prop.t = FALSE, prop.r = FALSE,
           dnn = c('predicted', 'actual'))
prop.table(table(data_test_pred2)) #ham(0.8683453) spam(0.1316547)


#86% of my email predicted correctly by the model as Not-spam(ham), and rest 13% are predicted as spam.