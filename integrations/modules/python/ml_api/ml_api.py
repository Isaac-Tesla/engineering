#!/usr/bin/python

""" 

Turn off Tensorflow 2.x warning messages about GPU.

Environment varaible: TF_CPP_MIN_LOG_LEVEL

0 = all messages are logged (default behavior)
1 = INFO messages are not printed
2 = INFO and WARNING messages are not printed
3 = INFO, WARNING, and ERROR messages are not printed

"""
import os
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2' 


import json
from flask import Flask
from flask import request
import tensorflow as tf


class MLAPI():

    """
    Class Notes
    -----------
     - Loads a machine learning model and makes it available 
         as an API endpoint to post data to and get results
         back from the model.

    To fix:
    -------
     - Unit tests to ensure this API works with all model 
         types.

    """

    def run_api(self, api_port: int, model_name: str) -> str:
        """
        Summary: Loads a Flask API endpoint to collect in a
            json object through a post method. Loads an
            existing *.h5 model and runs the input against 
            that model. Outputs the predictions.

        Returns:
            [string]: Results of the prediction.
        """
        pass

        app = Flask(__name__)

        @app.route('/', methods=['POST'])
        def get_model():
            if request.method == 'POST':

                data = request.json
                input_data = data['data']

                model = tf.keras.models.load_model(model_name) # load the *.h5 model

                predictions = model.predict(input_data) # run the input against the model

                return str(predictions)

        app.run(port=api_port)