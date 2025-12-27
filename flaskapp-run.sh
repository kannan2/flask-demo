#!/usr/bin/env bash
####################################################################################################
#                                        PyApp-run.sh                                        #
# A script to run a Python application with optional installation and version display.        #
# Free to use/edit/distribute the code below by                                                    #
# giving proper credit to the Author                                                   #
#                                                                                                  #
####################################################################################################
echo "Starting Python Flask Application Setup..."
echo "Seting up virtual environment and installing dependencies..."
if [ -d "venv" ]; then
    echo "Virtual environment already exists. Skipping creation."
else
    echo "Creating virtual environment..."
    python3 -m venv venv
fi

echo "Activating virtual environment and installing requirements..."
source venv/bin/activate
echo "Installing required packages..."
pip3 install -r requirements.txt
export FLASK_APP=app.py
echo "Running the Flask application..."
# add --host=0.0.0.0 --port=5000 to the flask run command if you want to specify host and port and to allow external access
flask run --host=0.0.0.0 > ~/flask-demo/flask-demo.log 2>&1 &
echo "Flask application is running in the background. Logs are being written to ~/flask-demo/flask-demo.log"