#!/bin/bash
sudo apt update &&
sudo apt install nginx -y &&
echo -e "events {}\nhttp {\n    server {\n        location / {\n            proxy_pass http://${web_server_ip}:${web_server_port}/;\n        }\n    }\n}" | sudo tee /etc/nginx/nginx.conf &&

# Restart Nginx
sudo systemctl restart nginx