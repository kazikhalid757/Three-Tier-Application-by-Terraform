#!/bin/bash
sudo apt update -y
sudo apt install -y nginx
systemctl start nginx 