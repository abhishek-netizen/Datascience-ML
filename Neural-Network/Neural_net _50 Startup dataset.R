#Build a Neural Network model for 50_startups data to predict profit 
data <- read.csv(file.choose())
View(data)
#creating dummies
install.packages("dummies")
library("dummies")
data1 <- dummy.data.frame(data)
View(data1)
levels(data$State) #checking the level of state variable levels=3
#custom normalization function
normalize <- function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
}
#apply normalization over the dummies
data1$R.D.Spend <- normalize(data1$R.D.Spend)
data1$Administration <- normalize(data1$Administration)
data1$Marketing.Spend <- normalize(data1$Marketing.Spend)
data1$StateCalifornia <- normalize(data1$StateCalifornia)
data1$StateFlorida <- normalize(data1$StateFlorida)
data1$`StateNew York` <- normalize(data1$`StateNew York`)
data1$Statenyc <- data1$`StateNew York`
data1 <- data1[-6]
data1
data1$Profit <- normalize(data1$Profit)
View(data1)
#creating data partition
training <- data1[1:38, ]
View(training)
testing  <- data1[39:50, ]
## Training a model on the data ----
# train the neuralnet model
install.packages("neuralnet")
library("neuralnet")
# simple ANN with only a single hidden neuron
model <- neuralnet(formula = Profit~Administration+Marketing.Spend+StateCalifornia+
                   StateFlorida+Statenyc,data = data1)
summary(model)
# visualize the network topology
plot(model)
# Evaluating model performance pred_train <- predict(model,training)

# obtain model results
  data_new <- data1[-6]
results_model <- compute(model, data_new)
str(results_model)
predicted_strength <- results_model$net.result
predicted_strength
# examine the correlation between predicted and actual values
cor(predicted_strength, data1$Profit) #0.7781075
#77% predicted and actual data corelated to each other
## Improving model performance ----
# a more complex neural network topology with 10 hidden neurons
model2 <- neuralnet(formula = Profit~Administration+Marketing.Spend+StateCalifornia+
                     StateFlorida+Statenyc,data = data1,hidden = 10)
# plot the network
plot(model2)
#evaluating model performance
results_model2 <- compute(model2, data_new)
predicted_strength2 <- results_model2$net.result
predicted_strength2
#examining the correlation
cor(predicted_strength2,data1$Profit) # 0.7933233

#corelation increases from 77% to 79% when we used 10 hidden neurons
