from flask import Flask, render_template, request
from sklearn.externals import joblib
import pandas as pd
import numpy as np

app = Flask(__name__)

mul_reg = open("libia1.pkl", "rb")
ml_model = joblib.load(mul_reg)

@app.route("/")
def home():
    return render_template('home.html')


@app.route("/predict", methods=['GET', 'POST'])
def predict():
    if request.method == 'POST':
        try:
            MONTH = float(request.form['MONTH'])
            DAY = float(request.form['DAY'])
            DAY_OF_WEEK = float(request.form['DAY_OF_WEEK'])
            AIRLINE = float(request.form['AIRLINE'])
            ORIGIN_AIRPORT= float(request.form['ORIGIN_AIRPORT'])
            DESTINATION_AIRPORT = float(request.form['DESTINATION_AIRPORT'])
            SCHEDULED_DEPARTURE = float(request.form['SCHEDULED_DEPARTURE'])
            ARRIVAL_TIME = float(request.form['ARRIVAL_TIME'])
            ARRIVAL_DELAY = float(request.form['ARRIVAL_DELAY'])
            SCHEDULED_TIME = float(request.form['SCHEDULED_TIME'])
            DEPARTURE_TIME = float(request.form['DEPARTURE_TIME'])
            SCHEDULED_ARRIVAL = float(request.form['SCHEDULED_ARRIVAL'])
            ELAPSED_TIME = float(request.form['ELAPSED_TIME'])
            pred_args = [MONTH,DAY,DAY_OF_WEEK,AIRLINE,ORIGIN_AIRPORT,DESTINATION_AIRPORT,SCHEDULED_DEPARTURE,DEPARTURE_TIME,SCHEDULED_ARRIVAL,ARRIVAL_TIME,ARRIVAL_DELAY,SCHEDULED_TIME,ELAPSED_TIME]
            pred_args_arr = np.array(pred_args)
            pred_args_arr = pred_args_arr.reshape(1, -1)
            # mul_reg = open("multiple_regression_model.pkl", "rb")
            # ml_model = joblib.load(mul_reg)
            model_prediction = ml_model.predict(pred_args_arr)
            model_prediction = round(float(model_prediction), 2)
        except ValueError:
            return "Please check if the values are entered correctly"
    return render_template('predict.html', prediction = model_prediction)


if __name__ == "__main__":
    app.run(debug=True)
