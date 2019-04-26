#!/bin/bash

virtualenv venv
source venv/bin/activate

pip install Django
pip install Pillow
pip install Pygments
pip install docutils
pip install markdown2
pip install pdfrw
pip install PyPDF2
pip install reportlab
pip install rst2pdf
pip install dj-database-url
pip install gunicorn
pip install mysql-connector
pip install uwsgi
