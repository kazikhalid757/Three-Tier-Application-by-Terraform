#!/bin/bash
set -e

# Update packages
sudo yum update -y

# Install Nginx
sudo amazon-linux-extras enable nginx1
sudo yum install -y nginx

# Start and enable Nginx on boot
sudo systemctl start nginx
sudo systemctl enable nginx

# Replace placeholder backend URL in frontend code
sudo sed -i "s|BACKEND_URL|${backend_url}|g" /usr/share/nginx/html/index.html

# Restart Nginx to apply changes
sudo systemctl restart nginx
