#!/bin/bash
sudo apt update -y
sudo apt install -y nodejs npm git
git clone git@github.com:your-org/backend-repo.git /home/ubuntu/backend
cd /home/ubuntu/backend
npm install
npm start
