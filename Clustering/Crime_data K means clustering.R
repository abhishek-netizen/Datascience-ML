data <- read.csv(file.choose())
View(data)

data1 <- data[-1] #removing 'X'
df <- scale(data1) #scle the columns
View(df)
# View the firt 3 rows of the data
head(df,n=3)
# Compute k-means with k = 4
set.seed(123)
#As k-means clustering algorithm starts with k randomly selected centroids, 
#it’s always recommended to use the set.seed() function 
#in order to set a seed for R’s random number generator
km.res <- kmeans(df, 4, nstart = 50)
#As the final result of k-means clustering result is sensitive to the random starting assignments,
#we specify nstart = 50. This means that R will try 50 different random starting assignments 
#and then select the best results corresponding to the one with the lowest within cluster variation. 
#The default value of nstart in R is one.
#print the result
print(km.res)
#withiness sum of sq should be minimum and betweeness should be large
#It’s possible to compute the mean of each variables by clusters using the original data:
a=aggregate(data1,by=list(cluster=km.res$cluster),mean)
a
data3 <- data[1]
b=head(data3,4)
cbind(b,a) #cbinding 'X' with the 'mean of clusters'
#---
# Cluster number for each of the observations
E1=head(km.res$cluster,4)
# A vector of integers (from 1:k) indicating the cluster to which each point is allocated
R1=cbind(b,E1)
R1
# Cluster size=The number of observations in each cluster
E2=head(km.res$size)
R2=cbind(b,E2)
R2
#Cluster means:A matrix of cluster centers (cluster means)
E3=head(km.res$centers)
R3=cbind(b,E3)
R3
#totss: The total sum of squares (TSS), i.e ???(xi-x¯)2. TSS nothing but measure of the total variance in the data.
E4=km.res$totss
E4 #196
#withinss: Vector of within-cluster sum of squares, one component per cluster
E5=km.res$withinss
E5
#tot.withinss:Total within-cluster sum of squares, 
E6=km.res$tot.withinss
E6#56.40317
#The between-cluster sum of squares,(totss-tot.withinss)
E7=km.res$betweenss
E7# 139.5968
##iter.max: The maximum number of iterations allowed. Default value is 10.
E8 <- km.res$iter 
E8
E8
cbind(E1,E2,E4,E5,E5,E6,E7)
############### K-SELECTION ##################################

install.packages("factoextra")
library(factoextra) #to see beautiful elbow curve
#choose the right number of expected clusters 'K'
#Elbow method (look at the knee)
# plotting Elbow method for kmeans

fviz_nbclust(data1, kmeans, method = "wss") +
  geom_vline(xintercept = 4, linetype = 2)
#+geom_vline(xintercept = 4, linetype = 2)code is optional its just an intercept and type of line --/...
#Elbow curve also suggesting us to choose K as 4 only
#After the 4 data is not varying much

############### Visualize Kmeans Clustering ####################
# use repel = TRUE to avoid overplotting
fviz_cluster(km.res, data1, ellipse.type = "norm",repel = TRUE)

# Change the color palette and theme
fviz_cluster(km.res, data1,palette = "Set2", ggtheme = theme_minimal())

############### we can also ask R for K selection ##############
install.packages("kselection")
library("kselection")
k <- kselection(data1, parallel = TRUE, k_threshold = 0.9, )
k
km.res1 <- kmeans(df, 2, nstart = 50)
print(km.res1)
#Dis advanatege:only 88.4 % is a measure of the total variance in your data set that is explained by the clustering. k-means