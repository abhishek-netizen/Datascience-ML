Airlines <- read.csv(file.choose())
Airlines <- na.omit(Airlines)
Airlines <- Airlines[-1]#dropping the column 'id'
View(Airlines)
str(Airlines)
df <- scale(Airlines) #scale the given data
View(df)
head(df,n=3) #seeing first 3 rows of the data
# Compute k-means 
set.seed(123)
#try to get K slection with the help of elbow curve
wss = (nrow(df)-1)*sum (apply(df, 2, var)) # Determine number of clusters by scree-plot 
for (i in 1:5) wss[i] = sum(kmeans(df, centers=i)$withinss)
plot(1:5, wss, type="b", xlab="Number of Clusters", ylab="Within groups sum of squares")   # Look for an "elbow" in the scree plot #
title(sub = "K-Means Clustering Scree-Plot")
#fit some model by taking K as 4
k.res <- kmeans(df,4)
print(k.res)
#withiness sum of squares should be low and betweeness sum of squares should be high.
final2<- data.frame(Airlines, k.res$cluster)
View(final2)
final3 <- final2[,c(ncol(final2),1:(ncol(final2)-1))]
View(final3)
aggregate(Airlines[,1:6], by=list(fit$cluster), FUN=mean)
#to see the cluster plots
install.packages("animation")
library(animation)
km <- kmeans.ani(df, 4)






###### different methods of k selection########
#install.packages("factoextra")
#library(factoextra)
#elbow curve
#fviz_nbclust(df,kmeans,method = "wss")

# Average silhouette for kmeans
#fviz_nbclust(df, kmeans, method = "silhouette")
# Gap statistic
# nboot = 50 to keep the function speedy. 
#gap_stat <- clusGap(a, FUN = kmeans, nstart = 50,K.max = 10, B = 3000)
#plot(gap_stat)



