#!/bin/bash

# Update package list
sudo yum update -y

# Install Nginx
sudo yum install -y nginx

# Start Nginx service
sudo systemctl start nginx

# Enable Nginx to start on boot
sudo systemctl enable nginx

# Create Nginx configuration for the frontend
sudo tee /etc/nginx/conf.d/backend_proxy.conf << EOF
server {
    listen 80;
    server_name _;

    location / {
        proxy_pass ${backend_url};  # Proxy to the backend URL provided
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOF

# Restart Nginx to apply changes
sudo systemctl restart nginx
