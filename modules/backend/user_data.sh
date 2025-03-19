#!/bin/bash
set -e  # Exit on error

# Update system packages
sudo yum update -y

# Install Node.js, npm, and PostgreSQL client
sudo yum install -y nodejs npm postgresql

# Export database credentials as environment variables
echo "export DB_HOST=${db_host}" | sudo tee -a /etc/environment
echo "export DB_USER=${db_user}" | sudo tee -a /etc/environment
echo "export DB_NAME=${db_name}" | sudo tee -a /etc/environment
echo "export DB_PASSWORD=${db_password}" | sudo tee -a /etc/environment

# Load environment variables
source /etc/environment

# Navigate to backend directory
cd /home/ec2-user/backend || exit

# Install dependencies
npm install

# Start the application in the background and log output
nohup npm start > backend.log 2>&1 &
