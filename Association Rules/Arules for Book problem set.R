book <- read.csv(file.choose())
View(book)
install.packages("arules")
library(arules)
install.packages("arulesViz")
library(arulesViz)
attach(book)
str(book) 
class(book)
# making rules using apriori algorithm 
#  changing support and confidence values to obtain different rules
?apriori
# Apriori algorithm for support =0.02,confidence =0.5
Arules=apriori(as.matrix(book),parameter=list(support=0.02,confidence=0.5))
Arules # set of 672 rules

inspect((sort(Arules,by="lift")))

# Building arule2 using apriori algorithm( the support value 0.04 & confidence =0.5)
arule2=apriori(as.matrix(book),parameter = list(support =0.04,confidence=0.5))
arule2 # set the 290 rules 

inspect((sort(arule2,by="lift"))) 

# Building arule3 using apriori algorithm( the support value 0.06 & confidence =0.8)
arule3=apriori(as.matrix(book),parameter = list(support =0.06,confidence=0.8))
arule3

inspect((sort(arule3,by="lift"))) 


# Different Ways of Visualizing Rules
plot(Arules,jitter=0)# to reduce over plotting Jitter is added 
plot(Arules,method="grouped")
plot(Arules[1:20],method = "graph") # only plotting the graph for top best 20 rules 

plot(arule2,jitter=0)# to reduce over plotting Jitter is added
plot(arule2,method="grouped")
plot(arule2[1:40],method = "graph") # only plotting the graph for top best 40 rules 


plot(arule3,jitter=0)# to reduce over plotting Jitter is added
plot(arule3,method="grouped")
plot(arule3[1:10],method = "graph") # only plotting the graph for top best 10 rules 
