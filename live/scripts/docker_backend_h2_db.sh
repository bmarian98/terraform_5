#!/bin/bash

sudo apt update &&

sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common &&

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg &&
sudo apt update &&

sudo apt install docker -y &&

sudo apt install docker.io -y &&

git clone "https://github.com/RevianLabs/devops-webapp-sample" &&

cd devops-webapp-sample &&

export SPRING_CONFIG_NAME=application-h2 &&

sudo docker build -t devops-webapp:1.0.0 . &&

sudo docker run -e SPRING_CONFIG_NAME=application-h2 -p 8080:8080 devops-webapp:1.0.0