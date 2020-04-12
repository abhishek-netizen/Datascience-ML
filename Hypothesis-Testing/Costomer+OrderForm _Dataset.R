install.packages("readxl")
library("readxl")
telecall <- read.csv(file.choose())
View(telecall)
#its appeared like input is also discrete 4 variable and output also discrete so
#we are comparing more than 2 population so we are performing Chi-square test.
#by stating following hypothesis
#H0:The manager wants to check whether the defective %  varies by centre
#H1:The manager wants to check whether the defective %  does not varies by centre
install.packages("dummies")
library("dummies")
#creating dummys
tel <- dummy.data.frame(telecall, sep=".")
View(tel)
#stacking the data
stacked_data <- stack(tel)
View(stacked_data)
#chi-square test
attach(stacked_data)
chisq.test(values,ind)
#p-value < 2.2e-16 p values is less than 0.05
#we are accepting alternate hypothesis
#i.e #H1:The manager wants to check whether the defective %  does not varies by centre