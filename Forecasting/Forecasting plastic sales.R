plastic <- read.csv(file.choose())
is.na(plastic) #checking for NA's
is.null(plastic) #checking null values
dim(plastic) #60 row 2 col
hist(plastic$Sales)
View(plastic) #Seasonality 12 months
# Pre Processing
# So creating 12 dummy variables
X <- data.frame(outer(rep(month.abb,length = 60), month.abb,"==") + 0 )
X
colnames(X) <- month.abb #Assigning month names to x by using built in R constraints month.abb
colnames(X)
plastic <- cbind(plastic,X)
View(plastic)

#input t column
plastic["t"] <- c(1:60)
View(plastic)

plastic["log_Sales"] <- log(plastic["Sales"])
View(plastic)
plastic["t_square"] <- plastic["t"]*plastic["t"]
View(plastic)

#prepreocessing is done
attach(plastic)
# Create data partitioning into training and testing 
install.packages("caret")
library("caret")
inTrainingLocal <- createDataPartition(plastic$Sales,p=0.75,list = F)
inTrainingLocal
training <- plastic[inTrainingLocal,]
View(training)
testing <- plastic[-inTrainingLocal,]
View(testing)

#Trying different model and checking RMSE value

########################### LINEAR MODEL #############################
linear_model <- lm(Sales~t,data = training)
summary(linear_model) #Multiple R-squared:  0.3151,p-value: 3.31e-05
linear_pred <- data.frame(predict(linear_model,interval = 'predict',newdata = testing))
linear_pred
rmse_linear <- sqrt(mean((testing$Sales-linear_pred$fit)^2, na.rm = T))
rmse_linear #201.7109
######################### Exponential #################################
expo_model <- lm(log_Sales ~ t, data = training)
summary(expo_model)#Multiple R-squared:  0.3074,p-value: 4.332e-05
expo_pred <- data.frame(predict(expo_model, interval='predict', newdata = testing))
expo_pred
rmse_expo <- sqrt(mean((testing$Sales-expo_pred$fit)^2, na.rm = T))                        
rmse_expo #1196.091
######################### Quadratic ####################################
Quad_model <- lm(Sales ~ t + t_square, data = training)
summary(Quad_model)#Multiple R-squared:  0.3152 #p-value: 0.0001999
Quad_pred <- data.frame(predict(Quad_model, interval='predict', newdata=testing))
rmse_Quad <- sqrt(mean((testing$Sales-Quad_pred$fit)^2, na.rm=T))
rmse_Quad #201.2617
######################### Additive Seasonality #########################
sea_add_model <- lm(Sales ~ Jan+Feb+Mar+Apr+May+Jun+Jul+Aug+Sep+Oct+Nov, data = training)
summary(sea_add_model)#Multiple R-squared:  0.7204,p-value: 4.394e-07
sea_add_pred <- data.frame(predict(sea_add_model, interval = 'predict',newdata=testing))
rmse_sea_add <- sqrt(mean((testing$Sales-sea_add_pred$fit)^2, na.rm = T))
rmse_sea_add #182.2004
######################## Additive Seasonality with Quadratic #################
Add_sea_Quad_model <- lm(Sales ~ t+t_square+Jan+Feb+Mar+Apr+May+Jun+Jul+Aug+Sep+Oct+Nov, data = training)
summary(Add_sea_Quad_model)#Multiple R-squared:  0.9606,p-value: < 2.2e-16
Add_sea_Quad_pred <- data.frame(predict(Add_sea_Quad_model, interval='predict', newdata=testing))
rmse_Add_sea_Quad <- sqrt(mean((testing$Sales - Add_sea_Quad_pred$fit)^2, na.rm=T))
rmse_Add_sea_Quad #97.95137
######################## Multiplicative Seasonality #########################
multi_sea_model <- lm(log_Sales ~ Jan+Feb+Mar+Apr+May+Jun+Jul+Aug+Sep+Oct+Nov, data = training)
summary(multi_sea_model) #Multiple R-squared:  0.7301,p-value: 2.452e-07
multi_sea_pred <- data.frame(predict(multi_sea_model, newdata=testing, interval='predict'))
rmse_multi_sea <- sqrt(mean((testing$Sales-exp(multi_sea_pred$fit))^2, na.rm = T))
rmse_multi_sea #180.0456
# Preparing table on model and it's RMSE values 
table_rmse <- data.frame(c("rmse_linear","rmse_expo","rmse_Quad","rmse_sea_add","rmse_Add_sea_Quad","rmse_multi_sea"),c(rmse_linear,rmse_expo,rmse_Quad,rmse_sea_add,rmse_Add_sea_Quad,rmse_multi_sea))
colnames(table_rmse) <- c("model","RMSE")
View(table_rmse)

## Additive seasonality with Quadratic has least RMSE value #97.95137
write.csv(plastic, file="plasticSales.csv", row.names = F)
getwd()
############### Combining Training & test data to build Additive seasonality using Quadratic Trend ############
View(plastic)
Add_sea_Quad_model_final <- lm(Sales ~ t+t_square+Jan+Feb+Mar+Apr+May+Jun+Jul+Aug+Sep+Oct+Nov, data = plastic)
summary(Add_sea_Quad_model_final) #Multiple R-squared:  0.9435,p-value: < 2.2e-16
####################### Predicting new data #############################
pred_new <- predict(Add_sea_Quad_model_final, newdata = testing, interval = 'predict')
pred_new <- as.data.frame(pred_new)
View(pred_new)
#Visualization
plot(Add_sea_Quad_model_final)
# take all residual value of the model built & plot ACF plot
acf(Add_sea_Quad_model_final$residuals, lag.max = 10) 
A <- arima(Add_sea_Quad_model_final$residuals, order = c(1,0,0))
A$residuals
ARerrors <- A$residuals
acf(ARerrors, lag.max = 10)
# predicting next 12 months errors using arima( order =c(1,0,0)) only Ar

install.packages("forecast")
library(forecast)
errors_12 <- forecast(A, h = 12)
future_errors <- data.frame(errors_12)
View(future_errors)
class(future_errors)
future_errors <- future_errors$Point.Forecast
# predicted values for new data + future error values 
predicted_new_values <- pred_new + future_errors
View(predicted_new_values)
write.csv(predicted_new_values, file = "predicted_new_values.csv", row.names = F)
getwd()

