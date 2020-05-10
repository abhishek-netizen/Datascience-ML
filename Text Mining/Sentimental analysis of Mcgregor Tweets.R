tweet=readLines(file.choose())
View(tweet)
head(tweet)
install.packages("tm")
library("tm")
##############Data Cleaning ##############
#cleaning the data tweet
clean_text <- tolower(tweet) #to lower cases
head(clean_text)
clean_text1 <- gsub(pattern = "\\W", replace = " " ,clean_text) #Remove punctations
head(clean_text1)
clean_text2 <- gsub(pattern = "\\d", replace = " ", clean_text1) #remove digits
head(clean_text2)
install.packages("NLP")
library("NLP")
stopwords() #let’s see a preview of stopwords using stopwords() command.
clean_text3 <- removeWords(clean_text2,words = c(stopwords(),"u fe f","â","ai"))
head(clean_text3)
View(clean_text3)
clean_text4  <- gsub(pattern = "\\b[A-z]\\b{1}", replace = " ", clean_text3 ) #lets remove single letter
View(clean_text4)
#\\b[A-z] represents strings with any letter between a-z.
#b{1} says that string ends with length 1
clean_text5 <- stripWhitespace(clean_text4) #finally removing white spaces 
View(clean_text5)
######### Emotion Mining ###############
install.packages("syuzhet")
library(syuzhet)
library("tm")
install.packages("plotly")
library("plotly")
s_v <- get_sentences(clean_text5)
syuzhet <- get_sentiment(s_v,method = "syuzhet")
bing <- get_sentiment(s_v,method = "bing")
afinn <- get_sentiment(s_v,method = "afinn")
nrc <- get_sentiment(s_v,method = "nrc")
sentiments <- data.frame(syuzhet,bing,afinn,nrc)
View(sentiments)
emotions <- get_nrc_sentiment(clean_text5)
head(emotions)
#anger", "anticipation", "disgust", "fear", "joy", "sadness", 
#"surprise", "trust", "negative", "positive."
emo_bar <- colSums(emotions)
emo_bar
barplot(emo_bar)
emo_sum <- data.frame(count=emo_bar,emotion=names(emo_bar))
# To extract the sentence with the most negative emotional valence
negative <- s_v[which.min(syuzhet)]
negative
# and to extract the most positive sentence
positive <- s_v[which.max(syuzhet)]
positive
View(positive)

#plot trajectory
plot(syuzhet, type = "l", main = "Plot Trajectory",
     xlab = "Narrative Time", ylab = "Emotional Valence")