mymovies <- read.csv(file.choose())
View(mymovies)
attach(mymovies)
library(arules)
library(arulesViz)

str(mymovies) ## data set which type we can see by this function 

# Building rules by using the apriori algorithm(support=0.006 and confidence=0.7)
arules1=apriori(as.matrix(mymovies[6:15]),parameter =list(support=0.006,confidence = 0.7))
arules1 # set of   79 rules 

inspect(sort(arules1,by="lift"))# Sort the Highest lift ratio in decending order 

# Building rules by using the apriori algorithm(support=0.3 and confidence=0.5)
arules2=apriori(as.matrix(mymovies[6:15]),parameter =list(support=0.3,confidence = 0.5))
arules2 # set of   15  rules 

inspect(sort(arules2,by="lift"))# Sort the Highest lift ratio in decending order 


# Building rules by using the apriori algorithm(support=0.03 and confidence=0.4)
arules3=apriori(as.matrix(mymovies[6:15]),parameter =list(support=0.03,confidence = 0.4))
arules3 # set of    108 rules 

inspect(sort(arules3,by="lift"))# Sort the Highest lift ratio in decending order 






# Different Ways of Visualizing Rules
plot(arules1,jitter=0)# to reduce over plotting Jitter is added 
plot(arules1,method="grouped")
plot(arules1[1:6],method = "graph") # only plotting the graph for top best 6 rules

plot(arules2,jitter=0)# to reduce over plotting Jitter is added 
plot(arules2,method="grouped")
plot(arules2[1:10],method = "graph") # only plotting the graph for top best 10 rules

plot(arules3,jitter=0)# to reduce over plotting Jitter is added 
plot(arules3,method="grouped")
plot(arules3[1:70],method = "graph") # only plotting the graph for top best 70  rules

