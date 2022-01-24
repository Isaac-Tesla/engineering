#!/usr/bin/python

# posts the model to the api.

import requests
import json
import numpy as np

lst = [[0,1,1]]
arr = np.array(lst)

params = {'param0': 'param0', 'param1': 'param1'}
data = {'params': params, 'arr': arr.tolist()}

response = requests.post(url="http://localhost:5000", json=data)

print(response.text)