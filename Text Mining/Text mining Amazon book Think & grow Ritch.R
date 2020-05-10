install.packages("rvest")
library("rvest")
install.packages("XML")
library("XML")
install.packages("magrittr")
library("magrittr")
############# Amazon BOOK  Reviews Extraction ###########
aurl <-"https://www.amazon.in/Think-Grow-Rich-Napoleon-Hill/dp/8192910911/ref=zg_bs_books_home_2?_encoding=UTF8&psc=1&refRID=JB26B68XMMXYTPY2XJ10#customerReviews"
amazon_reviews <- NULL
for (i in 1:5) {
  murl <- read_html(as.character(paste(aurl,i,sep="=")))
  rev <- murl %>%
    html_nodes(".review-text") %>%
    html_text()
  amazon_reviews <- c(amazon_reviews,rev)
  View (amazon_reviews)
}
write.csv(amazon_reviews,"Man's Search For Meaning.txt",row.names = F)
getwd()
#Extraction completed


###################Text cleaning##################
book <- readLines(file.choose())
View(book)
#installing required packages
install.packages("tm")
library("tm")
#Load data as corpus
#VectorSource() creates character vectors
mydata <- Corpus(VectorSource(book))
View(mydata)
#convert to lower cases
# convert to lower case
mydata <- tm_map(mydata, content_transformer(tolower))
View(mydata)
#remove if any emojis
mydata <- tm_map(mydata,content_transformer(gsub),pattern="\\W",replace=" ")
View(mydata)
# remove URLs
removeURL <- function(x) gsub("http[^[:space:]]*", "", x)
mydata <- tm_map(mydata, content_transformer(removeURL))
# remove anything other than English letters or space
removeNumPunct <- function(x) gsub("[^[:alpha:][:space:]]*", "", x)
mydata <- tm_map(mydata, content_transformer(removeNumPunct))

# remove stopwords
stopwords()
mydata <- tm_map(mydata, removeWords, stopwords("english"))
# remove extra whitespace
mydata <- tm_map(mydata, stripWhitespace)
# Remove numbers
mydata <- tm_map(mydata, removeNumbers)
# Remove punctuations
mydata <- tm_map(mydata, removePunctuation)
#Stemming is the process of gathering words of similar origin into one word 
#for example "communication", "communicates", "communicate".
#We shall use the SnowballC library.
install.packages("SnowballC")
library(SnowballC)
mydata <- tm_map(mydata, stemDocument)

####################Sentiment Analysis##################


#It is based on word polarities, it takes into account positive or negative words and 
#neutral words are dismissed.
#Sentiment analysis is done based on lexicons.
# a lexicon is a selection of words with the two polarities
#that can be used as a metric in sentiment analysis.
install.packages("syuzhet")
library(syuzhet)
#Just for visualization
install.packages("ggplot2")
library(ggplot2)

#sentiment mining using the get_nrc_sentiment()function
a <- as.character(mydata)
result <- get_nrc_sentiment(a)
#change result from a list to a data frame and transpose it 
result1<-data.frame(t(result))
#rowSums computes column sums across rows for each level of a #grouping variable.
new_result <- data.frame(rowSums(result1))
#name rows and columns of the dataframe
names(new_result)[1] <- "count"
new_result <- cbind("sentiment" = rownames(new_result), new_result)
new_result
rownames(new_result) <- NULL
#plot the first 8 rows,the distinct emotions except positive and negative col
qplot(sentiment, data=new_result[1:8,], weight=count, geom="bar",fill=sentiment)+ggtitle("Interstellar moview imdb reviews sentiments")
#plot the last 2 rows ,positive and negative separately]
qplot(sentiment, data=new_result[9:10,], weight=count, geom="bar",fill=sentiment)+ggtitle("Interstellar moview imdb reviews sentiments")

