#!/bin/bash

sudo apt update
sudo apt install nginx python3-pip virtualenv

chmod u+x create_venv.sh
./create_venv.sh

source venv/bin/activate
cd wcompass
python manage.py collectstatic
