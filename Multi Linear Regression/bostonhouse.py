#!/usr/bin/env python
# coding: utf-8

# In[ ]:


#boston housing challenge


# In[60]:


import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
#importing the dataset 
from sklearn.datasets import load_boston 
boston = load_boston()  #Boston is Inbuilt dataset
boston
boston.data.shape #(506, 13)
boston.feature_names
#Converting data from nd-array to dataframe
data=pd.DataFrame(boston.data)
data.columns=boston.feature_names #adding feature names to the data
data.head(10)
#CRIM     per capita crime rate by town
#ZN       proportion of residential land zoned for lots over 25,000 sq.ft.
#INDUS    proportion of non-retail business acres per town
#CHAS     Charles River dummy variable (= 1 if tract bounds river; 0 otherwise)
#NOX      nitric oxides concentration (parts per 10 million)
#RM       average number of rooms per dwelling
#AGE      proportion of owner-occupied units built prior to 1940
#DIS      weighted distances to five Boston employment centres
#RAD      index of accessibility to radial highways
#TAX      full-value property-tax rate per $10,000
#PTRATIO  pupil-teacher ratio by town
#B        1000(Bk - 0.63)^2 where Bk is the proportion of blacks by town
#LSTAT    % lower status of the population
#MEDV     Median value of owner-occupied homes in $1000's

#Adding ‘Price’ column to the dataset,the dataset stored separetly so
data['Price']=boston.target
#data.head()
data.describe()
#info
#data.info()

#Train test split
x=boston.data
y=boston.target
#splitting data to training and testing
from sklearn.model_selection import train_test_split
x_train,x_test,y_train,y_test=train_test_split(x,y,test_size=0.2,random_state=0)
#fitting multilinear regression model
from sklearn.linear_model import LinearRegression
regressor=LinearRegression()
regressor.fit(x_train,y_train)
#predicting the test result
y_pred=regressor.predict(x_test)
# Plotting Scatter graph to show the prediction  
# results - 'ytrue' value vs 'y_pred' value
plt.scatter(y_test,y_pred,c='green')
plt.xlabel("Price: in $1000's") 
plt.ylabel("Predicted value") 
plt.title("True value vs predicted value : Linear Regression") 
plt.show() 
# Results of Linear Regression.
from sklearn.metrics import mean_squared_error
mse=mean_squared_error(y_test,y_pred)
print("Mean Square Error : ", mse) #33.44897999767653

#our model is only 66.55% accurate. So, the prepared model is not very good for predicting the housing prices.
#model needs improvization


# In[ ]:





# In[ ]:




