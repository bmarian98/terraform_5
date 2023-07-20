#!/bin/bash
sleep 30  # Add a delay of 30 seconds

sudo apt update -y &&

# sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common &&

# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg &&
# sudo apt update &&

sudo apt install -y docker &&
sudo apt install -y docker.io &&

sudo apt install -y awscli &&
sudo apt install -y unzip  &&


mkdir -p ~/app && cd ~/app &&

aws s3 cp "${s3_app}/${zip_name}.zip" . &&
unzip "${zip_name}.zip"&&
cd "$(ls -d */ | head -n 1)" &&

chmod +x mvnw &&

sudo docker build -t devops-webapp:1.0.0 . &&

sudo docker run -p 8080:8080 -e DB_USER="${db_user}" -e DB_PASS="${db_pass}" -e DB_URL="${db_url}" devops-webapp:1.0.0