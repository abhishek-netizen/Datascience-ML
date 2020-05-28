data <- read.csv(file.choose())
View(data)
data1 <- data[-1:-2]
dat1 <- na.omit(data1)
View(dat1)
install.packages("dummies")
library("dummies")
dmy <- dummy.data.frame(dat1)
View(dmy)
#custom normalization function
normalize <- function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
}

#tried to apply on normalization(custom functn & also scale), looks like they are....
#.......creating Atomic vector thats another trouble

#apply normalization
#if the variables had only once and zeros we can exclude them no need to apply normalization on them . but here it inlcuded
dmy$FFMC <- normalize(dmy$FFMC)
dmy$DMC <- normalize(dmy$DMC)
dmy$DC <- normalize(dmy$DC)
dmy$ISI <- normalize(dmy$ISI)
dmy$temp <- normalize(dmy$temp)
dmy$RH <- normalize(dmy$RH)
dmy$wind <- normalize(dmy$wind)
dmy$rain <- normalize(dmy$rain)
dmy$area <- normalize(dmy$area)
dmy$dayfri <- normalize(dmy$dayfri)
dmy$daymon <- normalize(dmy$daymon)
dmy$daysat <- normalize(dmy$daysat)
dmy$daysun <- normalize(dmy$daysun)
dmy$daythu <- normalize(dmy$daythu)
dmy$daytue <- normalize(dmy$daytue)
dmy$daywed <- normalize(dmy$daywed)
dmy$monthapr <- normalize(dmy$monthapr)
dmy$monthaug <- normalize(dmy$monthaug)
dmy$monthdec <- normalize(dmy$monthdec)
dmy$monthfeb <- normalize(dmy$monthfeb)
dmy$monthjan <- normalize(dmy$monthjan)
dmy$monthjul <- normalize(dmy$monthjul)
dmy$monthjun <- normalize(dmy$monthjun)
dmy$monthmar <- normalize(dmy$monthmar)
dmy$monthmay <- normalize(dmy$monthmay)
dmy$monthnov <- normalize(dmy$monthnov)
dmy$monthoct <- normalize(dmy$monthoct)
dmy$monthsep <- normalize(dmy$monthsep)
dmy$size_categorylarge <- normalize(dmy$size_categorylarge)
dmy$size_categorysmall <- normalize(dmy$size_categorysmall)
View(dmy)
#create data partion 
install.packages("caret")
library("caret")
inTrainingLocal <- createDataPartition(dmy$size_categorylarge,p=.75,list = F)
training <- dmy[inTrainingLocal,]
testing <- dmy[-inTrainingLocal,]

## Train the model on data ----
# train the neuralnet model
install.packages("neuralnet")
library("neuralnet")
# simple ANN with only a single hidden neuron
model <- neuralnet(formula =size_categorylarge~FFMC+DMC+DC+ISI+temp+RH+wind+rain+area+dayfri+daymon+daysat+daysun+daythu+daywed+daytue+
                     monthapr+monthaug+monthdec+monthfeb+monthjan+monthjul+monthjun+monthmar+monthmay+monthnov+monthoct,data = dmy)
summary(model)
# visualize the network topology
plot(model)
# Evaluating model performance pred_train <- predict(model,training)
data_new <- dmy[-29]
data_new
results_model <- compute(model, data_new)
str(results_model)
predicted_strength <- results_model$net.result
predicted_strength
# examine the correlation between predicted and actual values
cor(predicted_strength, dmy$size_categorylarge) #0.9602553
#96% predicted and actual data corelated to each other.

## Improving model performance ----
# a more complex neural network topology with 10 hidden neurons

model2 <- neuralnet(formula =size_categorylarge~FFMC+DMC+DC+ISI+temp+RH+wind+rain+area+dayfri+daymon+daysat+daysun+daythu+daywed+daytue+
                     monthapr+monthaug+monthdec+monthfeb+monthjan+monthjul+monthjun+monthmar+monthmay+monthnov+monthoct,data = dmy,hidden = 10)
#result model
results_model1 <- compute(model2, data_new)
predicted_strength1 <- results_model1$net.result
predicted_strength1

cor(predicted_strength1, dmy$size_categorylarge) #0.9989094


#Looks like im overfitting my model with an accuracy rate of 99%

