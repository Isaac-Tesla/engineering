#!/usr/bin/python

import os
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2' 

# 0 = all messages are logged (default behavior)
# 1 = INFO messages are not printed
# 2 = INFO and WARNING messages are not printed
# 3 = INFO, WARNING, and ERROR messages are not printed

import tensorflow as tf
import numpy as np
import pandas as pd
from tensorflow import keras
from tensorflow.keras import layers
import datetime




def main():  

    print("TensorFlow version:", tf.__version__)

    train_examples = np.array([ [0,0,1],
                                [0,1,1],
                                [1,0,1],
                                [1,1,1]
                             ])
    train_labels = np.array([[0,
                              1,
                              1,
                              0]]).T

    test_examples = np.array([ [0,1,1] ])
    test_labels = np.array([ [1] ])


    train_dataset = tf.data.Dataset.from_tensor_slices((train_examples, train_labels))
    test_dataset = tf.data.Dataset.from_tensor_slices((test_examples, test_labels))

    inputs = keras.Input(shape=(3,))
    print(inputs.dtype)

    dense = layers.Dense(3, activation="sigmoid")

    x = dense(inputs)
    x = layers.Dense(3, activation="sigmoid")(x)
    outputs = layers.Dense(3)(x)

    model = keras.Model(inputs=inputs, outputs=outputs, name="basic_model")
    model.summary()

    # compile model
    model.compile(
        loss=keras.losses.SparseCategoricalCrossentropy(from_logits=True),
        optimizer=keras.optimizers.RMSprop(),
        metrics=["accuracy"],
    )

    log_dir = "logs/fit/" + datetime.datetime.now().strftime("%Y%m%d-%H%M%S")
    tensorboard_callback = tf.keras.callbacks.TensorBoard(log_dir=log_dir, histogram_freq=1)

    history = model.fit(train_examples, train_labels, batch_size=3, epochs=2, validation_split=0.2, 
          callbacks=[tensorboard_callback])

    test_scores = model.evaluate(test_examples, test_labels, verbose=2)
    print("Test loss:", test_scores[0])
    print("Test accuracy:", test_scores[1])

    # save the model to use in the Flask API.
    model.save('basic_model.h5')

    # Recreate the exact same model, including its weights and the optimizer
    model = tf.keras.models.load_model('basic_model.h5')

    test_examples2 = np.array([ [0,1,1] ])
    test_labels2 = np.array([ [1] ])

    # run the input against the model
    predictions = model.predict(test_examples2)

    print(predictions)


if __name__ == '__main__':
    main()