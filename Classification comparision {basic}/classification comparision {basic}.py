#!/usr/bin/env python
# coding: utf-8

# In[2]:


#Decision Tree
# importing necessary libraries 
from sklearn import datasets 
from sklearn.metrics import confusion_matrix 
from sklearn.model_selection import train_test_split 
  
# loading the iris dataset 
iris = datasets.load_iris() 
  
# X -> features, y -> label
X=iris.data
y=iris.target
# dividing X, y into train and test data 
X_train,X_test,y_train,y_test=train_test_split(X,y,random_state=0)
# training a DescisionTreeClassifier
from sklearn.tree import DecisionTreeClassifier
dtree_model = DecisionTreeClassifier(max_depth = 2).fit(X_train, y_train)
dtree_predictions=dtree_model.predict(X_test)
#creating a confusion matrix 
cm=confusion_matrix(y_test,dtree_predictions)
cm
accuracy =dtree_model.score(X_test, y_test)
accuracy


# In[3]:


#SVM
from sklearn import datasets 
from sklearn.metrics import confusion_matrix
from sklearn.model_selection import train_test_split
#loading iris dataset
iris=datasets.load_iris()
# X -> features, y -> label
X=iris.data
y=iris.target
# dividing X, y into train and test data 
X_train,X_test,y_train,y_test=train_test_split(X,y,random_state=0)
# training a linear SVM classifier
from sklearn.svm import SVC
svm_model_linear=SVC(kernel = 'linear',C=1).fit(X_train,y_train)
svm_predictions=svm_model_linear.predict(X_test)
# creating a confusion matrix
cm=confusion_matrix(y_test,svm_predictions)
cm
# model accuracy for X_test 
accuracy=svm_model_linear.score(X_test,y_test)
accuracy


# In[4]:


#KNN
from sklearn import datasets
from sklearn.metrics import confusion_matrix
from sklearn.model_selection import train_test_split
#loading the dataset
iris=datasets.load_iris()
# X -> features, y -> label
X=iris.data
y=iris.target
#split the datasets
X_train,X_test,y_train,y_test=train_test_split(X,y,random_state=0)
#lets train KNN
from sklearn.neighbors import KNeighborsClassifier 
knn=KNeighborsClassifier(n_neighbors=7).fit(X_train,y_train)
# accuracy on X_test
accuracy=knn.score(X_test,y_test) #model.score
print(accuracy)
#predict
knn_predictions=knn.predict(X_test)
knn_predictions
#confusion ,atrix
cm=confusion_matrix(y_test,knn_predictions)
cm


# In[5]:


#naiveBayes
from sklearn import datasets
from sklearn.metrics import confusion_matrix
from sklearn.model_selection import train_test_split
#loading the dataset
iris=datasets.load_iris()
# X -> features, y -> label
X=iris.data
y=iris.target
#split the datasets
X_train,X_test,y_train,y_test=train_test_split(X,y,random_state=0)
#lets train KNN
from sklearn.naive_bayes import GaussianNB 
gnb=GaussianNB().fit(X_train,y_train)
gnb_predictions=gnb.predict(X_test)
#accuracy of X_test
accuracy=gnb.score(X_test,y_test)
print(accuracy)
# creating a confusion matrix
cm = confusion_matrix(y_test, gnb_predictions) 
cm


# In[6]:




