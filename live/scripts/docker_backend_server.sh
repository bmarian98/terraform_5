#!/bin/bash

sudo apt update &&

sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common &&

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg &&
sudo apt update &&

sudo apt install docker -y &&

sudo apt install docker.io -y &&

sudo apt install awscli -y &&

mkdir -p ~/app && cd ~/app &&

aws s3 cp "${s3_app}" . --recursiv &&

chmod +x mvnw &&

sudo docker build -t devops-webapp:1.0.0 . &&

sudo docker run -p 8080:8080 -e DB_USER="${db_user}" -e DB_PASS="${db_pass}" -e DB_URL="${db_url}" devops-webapp:1.0.0