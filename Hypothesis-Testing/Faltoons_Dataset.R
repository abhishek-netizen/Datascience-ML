install.packages("readxl")
library("readxl")
pantaloons <- read_excel(file.choose())
View(pantaloons)
attach(pantaloons)
#its appeared to be x and  y both discreete and we are comparing 2 population with eachother so
#so we are taking on 2-propotion test with the following assumptions
#Ho= Proportions of Male and Female are same
#Ha= Proportions of Male and Female are not same
table1 <- table(pantaloons$Weekdays,pantaloons$Weekend)
table1
prop.test(x=c(66,47),n=c(167,120),conf.level = 0.95,correct = FALSE,alternative = "two.sided")
#p-value = 0.9517 which is greater than 0.05 so we are let go of alternate hypo and accept the null hypo.
#i.e Ho= Proportions of Male and Female are same % of male and female walking in to the store is not different
#sales manager comment is wrong.