#!/usr/bin/env python
# coding: utf-8

# In[ ]:


import pandas as pd
import matplotlib.pyplot as plt
data=pd.read_csv("User_Data.csv")    
data
for col in data.columns: 
    print(col)
#User ID
#Gender
#Age
#EstimatedSalary
#Purchased
df=data #better to have backup in case if we need in future.
df=df.drop(['User ID','Gender'], axis = 1)#I guess userid and Gender is not contributing to my analysis.
x=df.iloc[:,[0,1]].values
x
y=df.iloc[:,2].values
y

#Lets split the model into Train-Test-split
from sklearn.model_selection import train_test_split
x_train,x_test,y_train,y_test=train_test_split(x,y,test_size=0.25,random_state = 0) #75%train 25%test 
#If we don’t scale the features then Estimated Salary feature will dominate Age feature 
#when the model finds the nearest neighbor to a data point in data space.
#lets standardize the data
from sklearn.preprocessing import StandardScaler
sc_x=StandardScaler()
x_train = sc_x.fit_transform(x_train)  
x_test = sc_x.transform(x_test) 
#Model building
from sklearn.linear_model import LogisticRegression
classifier=LogisticRegression(random_state=0)
classifier.fit(x_train,y_train)
#predicting
y_pred=classifier.predict(x_test)
#confusion matrix
from sklearn.metrics import confusion_matrix
cm=confusion_matrix(y_test, y_pred)
print ("Confusion Matrix : \n", cm) 
#TruePostive + TrueNegative = 65 + 24
#FalseNegative + FalsePositive = 3 + 8
#Accuracy=65+24/[65+24+8+3]=0.89

from sklearn.metrics import accuracy_score
print ("Accuracy : ", accuracy_score(y_test, y_pred)) #0.89
#Our model acuurately predicting 89% variation in the dataset

#Scatter
from matplotlib.colors import ListedColormap
X_set, y_set = x_test, y_test 
X1,X2=np.meshgrid(np.arange(start=X_set[:,0].min()-1,
                            stop=X_set[:,0].max()+1,step=0.01),
                  np.arange(start=X_set[:,1].min()-1,
                           stop=X_set[:,1].max()+1,step=0.01))
plt.contourf(X1, X2, classifier.predict( 
             np.array([X1.ravel(), X2.ravel()]).T).reshape( 
             X1.shape), alpha = 0.75, cmap = ListedColormap(('red', 'green')))
plt.xlim(X1.min(), X1.max()) 
plt.ylim(X2.min(), X2.max())

for i,j in enumerate(np.unique(y_set)):
    plt.scatter(X_set[y_set==j,0],X_set[y_set==j,1],
               c=ListedColormap(('red','green'))(i),label=j)

plt.title('Classifier (Test set)') 
plt.xlabel('Age') 
plt.ylabel('Estimated Salary') 
plt.legend() 
plt.show() 

