#!/bin/bash

sudo apt update -y &&
sudo apt install openjdk-17-jre-headless -y &&
sudo apt install awscli -y &&

mkdir -p ~/app && cd ~/app &&

aws s3 cp "${s3_app}" . --recursiv &&

#SET DB ENV VAR
export DB_USER="${db_user}"
export DB_PASS="${db_pass}"
export DB_URL="${db_url}"

chmod +x mvnw &&
./mvnw --batch-mode clean install &&

java -jar target/devops-webapp-sample-1.0.0.jar

