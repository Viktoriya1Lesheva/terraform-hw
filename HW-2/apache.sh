#!/bin/bash
apt update -y
apt install apache2 -y
echo "Hello, World!" > /var/www/html/index.html
systemctl start apache2
systemctl enable apache2