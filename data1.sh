#!/bin/bash
sudo yum -y install  git
sudo yum -y install httpd
sudo systemctl start httpd
sudo systemctl enable httpd
sudo wget https://github.com/anitha8242/web-apps-1.git
sudo git clone  https://github.com/Akiranred/candy-crush.git /var/www/html/
