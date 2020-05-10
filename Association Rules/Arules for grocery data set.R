grocery <- read.csv(file.choose())
View(grocery)
library(arules)
library(arulesViz)
str(grocery) # we can check the data type 
# Building rules by using the apriori algorithm(support=0.006 and confidence=0.7)
arules1=apriori(grocery,parameter =list(support=0.006,confidence = 0.7))
arules1 # set of 115 rules 

inspect(sort(arules1,by="lift"))# Sort the Highest lift ratio in decending order 

# Building rules by using the apriori algorithm(support=0.004 and confidence=0.8)
arules2=apriori(grocery,parameter =list(support=0.004,confidence = 0.8))
arules2 # set of 140 rules 

inspect(sort(arules2,by="lift"))# Sort the Highest lift ratio in decending order 


# Building rules by using the apriori algorithm(support=0.008 and confidence=0.8)
arules3=apriori(grocery,parameter =list(support=0.008,confidence = 0.8))
arules3

inspect(sort(arules3,by="lift"))


# Different Ways of Visualizing Rules
plot(arules1,jitter=0)# to reduce over plotting Jitter is added 
plot(arules1,method="grouped")
plot(arules1[1:6],method = "graph") # only plotting the graph for top best 6 rules

plot(arules2,jitter=0)# to reduce over plotting Jitter is added
plot(arules2,method="grouped")
plot(arules2[1:40],method = "graph") # only plotting the graph for top best 40 rules

plot(arules3,jitter=0)# to reduce over plotting Jitter is added
plot(arules3,method="grouped")
plot(arules3[1:50],method = "graph") # only plotting the graph for top best 50 rules
