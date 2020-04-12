install.packages("readxl")
library("readxl")
lab <- read.csv(file.choose())
View(lab)
install.packages("plyr")
library("plyr")
labb=rename(lab, c("Laboratory.1"="lab1", "Laboratory.2"="lab2" ,"Laboratory.3"="lab3","Laboratory.4"="lab4"))
View(labb)
#Normality test 
attach(labb)
qqnorm(lab1)
qqline(lab1)
qqnorm(lab2)
qqline(lab2)
qqnorm(lab3)
qqline(lab3)
qqnorm(lab4)
qqline(lab4)
shapiro.test(lab1)
shapiro.test(lab2)
shapiro.test(lab3)
shapiro.test(lab4)
#p values greater than 0.05
#check for variances
Stacked_Data <- stack(labb)
View(Stacked_Data)
attach(Stacked_Data)
bartlett.test(values~ind, data=Stacked_Data) #p-value = 0.1069>0.05 variances are equal

Anova_results <- aov(values~ind,data = Stacked_Data)
summary(Anova_results)
#p values is lessser than desired
#accept alternate hypothesis
#which means there is any difference in average TAT among the different laboratories at 5% significance level.

