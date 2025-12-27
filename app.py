from flask import Flask, render_template
from flask import request

import logging
import os
import requests
import sys
import time
import xml.etree.ElementTree as ET

app = Flask(__name__)


def validate_response(resp, err_message):
    if resp.status_code != 200:
        print(err_message)
        sys.exit(1)


@app.route('/css-example')
def css_example():
    return render_template('css-example.html')


@app.route('/')
def index():
    text = 'Welcome to My First Flask App !!!'
    # return text
    return render_template('index.html', title=text)

@app.route('/hello')
def hello():
    return 'Hello, World'

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=80) # Specify port 80 and host 0.0.0.0
    