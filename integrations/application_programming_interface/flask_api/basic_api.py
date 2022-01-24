#!/usr/bin/python

import json
from flask import Flask
app = Flask(__name__)
@app.route('/')
def index():
    return json.dumps({'name': 'john', 'email': 'john@outlook.com'})
app.run()