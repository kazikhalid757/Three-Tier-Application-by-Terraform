#!/bin/bash

# Update package list
sudo apt-get update -y

# Install Nginx
sudo apt-get install -y nginx

# Start Nginx service
sudo systemctl start nginx

# Enable Nginx to start on boot
sudo systemctl enable nginx

# Create Nginx configuration for the frontend
sudo tee /etc/nginx/sites-available/default << EOF
server {
    listen 80;
    server_name _;

    location / {
        proxy_pass ${backend_url};
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
