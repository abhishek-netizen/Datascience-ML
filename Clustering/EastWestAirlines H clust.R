data <- read.csv(file.choose())
View(data)
data1 <- data[-1]
str(data1)
df <- scale(data1) #normalize the data by scale function
View(df)
d <- dist(df, method = "euclidean")
fit <- hclust(d, method="complete")
fit
plot(fit) #plotting cluster dendrogram
plot(fit, hang=-1)
groups1 <- cutree(fit, k=4)
rect.hclust(fit, k=4, border="red")
group<-as.matrix(groups)
final <- data.frame(data1, group)
View(final)

final1 <- final[,c(ncol(final),1:(ncol(final)-1))]
View(final1)
