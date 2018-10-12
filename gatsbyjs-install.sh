#!/bin/bash
# GET ALL USER INPUT
echo "Domain Name (eg. example.com)?"
read DOMAIN
echo "Project name (eg. gatsbyjs-dev)?"
read FOLDER
echo "Updating OS................."
sleep 2;
sudo apt-get update
sudo apt-get install build-essential -y
sudo apt-get install nginx -y
echo "Sit back and relax :) ......"
sleep 2;
cd /etc/nginx/sites-available/
sudo wget -O "$DOMAIN" https://raw.githubusercontent.com/bajpangosh/GatsbyJS-Easy-Deploy-to-Cloud/master/nginx-conf
sudo sed -i -e "s/example.com/$DOMAIN/" "$DOMAIN"
sudo ln -s /etc/nginx/sites-available/"$DOMAIN" /etc/nginx/sites-enabled/

echo "Setting up Cloudflare FULL SSL"
sleep 2;
sudo mkdir /etc/nginx/ssl
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt
sudo openssl dhparam -out /etc/nginx/ssl/dhparam.pem 2048
sudo mkdir "$FOLDER"
cd "$FOLDER"
sudo apt-get install nodejs -y
sudo apt-get install npm -y
sudo npm install --global gatsby-cli
sudo npm i v -compile-cache
gatsby new "$DOMAIN" https://github.com/gatsbyjs/gatsby-starter-default
sudo systemctl restart nginx.service
echo "GatsbyJS Installation & configuration succesfully finished.
Twitter: @TeamKloudboy
Twitter: @bajpangosh
e-mail: support@kloudboy.com
Bye!"
sleep 2;
sudo gatsby develop
