install.packages("readxl")
library("readxl")
dat <- read.csv(file.choose())
View(dat)
#Inputs are 4 discrete variables(east,west,north,south).
#Output is also discrete. We are trying to find out if proportions of male and female are similar or not across the regions
#We proceed with chi-square test by fallowing hypothesis

#Ho= Proportions of Male and Female are same
#Ha= Proportions of Male and Female are not same
attach(dat)
table(Observed.Values,East,West,North,South)
#since chi-sq holds only two values im stacking the columns
Stacked_Data <- stack(dat)
View(Stacked_Data)
attach(Stacked_Data)
#finally chi square
chisq.test(values,ind)
#p-value = 0.2931, which greater than 0.05.
#so we are accepting the null values.
#Hence proportion of male and female across regions is same.
