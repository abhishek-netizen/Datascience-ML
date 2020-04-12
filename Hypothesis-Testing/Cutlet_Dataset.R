install.packages("readxl")
library("readxl")
cutlet <- read.csv(file.choose())
View(cutlet)
#Normality test
shapiro.test(cutlet$Unit.A)
shapiro.test(cutlet$Unit.B)
qqnorm(cutlet$Unit.A)
qqline(cutlet$Unit.A)
#variance test
var.test(cutlet$Unit.A,cutlet$Unit.B) #variances are not equal
#as variances are not equal we are choosing "2-sample T-test" for Unequal variances.

############2 sample T Test ##################
#mean(cutlet$unit.A)=mean(cutlet$unit.B)
#mean(cutlet$unit.A) is not equal to mean(cutlet$unit.B)
attach(cutlet)
t.test(Unit.A,Unit.B,alternative = "two.sided",conf.level = 0.95,correct = FALSE)
# means
# null Hypothesis -> Equal means
# Alternate Hypothesis -> Unequal means

# p-value = 0.4723 > 0.05 accept Null Hypothesis 
# equal means
#there is any significant difference in the diameter of the cutlet between two units. 