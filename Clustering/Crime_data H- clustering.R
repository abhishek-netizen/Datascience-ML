crime <- read.csv(file.choose())
View(crime)
hist(crime$UrbanPop)
boxplot(crime)
install.packages("dplyr")
library("dplyr")
crime1 <- select(crime,-c(1))
#normalizing the data
normalized_data <- scale(crime1)
normalized_data
d <- dist(normalized_data,method = "euclidean")
fit <- hclust(d,method = "complete")
fit
plot(fit)
plot(fit,hang = -1)
groups <- cutree(fit,k=3)
rect.hclust(fit,k=3,border ="red")
membership <- as.matrix(groups)
final <- data.frame(crime1,membership)
View(final)
final1 <- final[,c(ncol(final),1:(ncol(final)-1))]
View(final1)
#combined just to see the data over area.
cbind(crime[1],final1)
