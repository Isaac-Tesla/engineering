#!/usr/bin/python

# the api to push requests to a model and get a result back
import os
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2' 
# 0 = all messages are logged (default behavior)
# 1 = INFO messages are not printed
# 2 = INFO and WARNING messages are not printed
# 3 = INFO, WARNING, and ERROR messages are not printed

import json
from flask import Flask
from flask import request
import tensorflow as tf
import numpy as np

app = Flask(__name__)

@app.route('/', methods=['POST'])
def get_model():
    # take in an array and output the predicted value.

    if request.method == 'POST':
        # get input of the array
        # [0,0,0]
        data = request.json
        params = data['params']
        input_array = np.array(data['arr'])

        model = tf.keras.models.load_model('basic_model.h5')
        # run the input against the model
        predictions = model.predict(input_array)

        return str(predictions)



app.run(port=5000)