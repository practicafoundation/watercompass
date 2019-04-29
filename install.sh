#!/bin/bash

sudo apt update
sudo apt install python3-pip python3-dev nginx

chmod u+x create_venv.sh
./create_venv.sh

source venv/bin/activate
cd wcompass
python manage.py collectstatic

# for testing
# sudo ufw allow 8000
# python manage.py runserver 0.0.0.0:8000
# go to the IPAddress:8000/technologies
# sudo ufw delete allow 8000

# test gunicorn with:
# gunicorn --bind 0.0.0.0:8000 wcompass.wsgi:application
# and go to IPAddress:8000/technologies

sudo cp /home/ubuntu/watercompass/systemd/gunicorn.service /etc/systemd/system/gunicorn.service
sudo cp /home/ubuntu/watercompass/systemd/gunicorn.socket /etc/systemd/system/gunicorn.socket
sudo systemctl start gunicorn
sudo systemctl enable gunicorn

# on modifications:
# sudo systemctl daemon-reload
# sudo systemctl restart gunicorn

# checking status:
# sudo systemctl status gunicorn.socket
# sudo systemctl status gunicorn

sudo cp /home/ubuntu/watercompass/nginx/wcompass /etc/nginx/sites-available/
sudo rm /etc/nginx/sites-enabled/default
sudo rm /etc/nginx/sites-enabled/wcompass
sudo ln -s /etc/nginx/sites-available/wcompass /etc/nginx/sites-enabled/wcompass


# test configuration with:
# sudo nginx -t

sudo systemctl daemon-reload
sudo service nginx restart

# install firewall
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 'Nginx HTTP'
sudo ufw allow 'OpenSSH'
sudo ufw allow ssh
sudo ufw enable
