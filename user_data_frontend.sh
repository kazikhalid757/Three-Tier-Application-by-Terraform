#!/bin/bash
sudo apt update -y
sudo apt install -y nginx git
git clone git@github.com:your-org/frontend-repo.git /var/www/html
