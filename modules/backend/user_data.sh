#!/bin/bash

# Update package list
sudo yum update -y

# Install Node.js and npm
curl -fsSL https://rpm.nodesource.com/setup_18.x | sudo bash -
sudo yum install -y nodejs

# Install PostgreSQL client
sudo yum install -y postgresql

# Create application directory
sudo mkdir -p /home/ec2-user/backend
sudo chown -R ec2-user:ec2-user /home/ec2-user/backend

# Set environment variables
echo "export DB_HOST=${db_host}" >> /home/ec2-user/.bashrc
echo "export DB_USER=${db_user}" >> /home/ec2-user/.bashrc
echo "export DB_NAME=${db_name}" >> /home/ec2-user/.bashrc
echo "export DB_PASSWORD=${db_password}" >> /home/ec2-user/.bashrc

# Create a simple Express.js application
cat > /home/ec2-user/backend/package.json << EOF
{
  "name": "backend",
  "version": "1.0.0",
  "main": "index.js",
  "scripts": {
    "start": "node index.js"
  },
  "dependencies": {
    "express": "^4.18.2",
    "pg": "^8.11.3"
  }
}
EOF

cat > /home/ec2-user/backend/index.js << EOF
const express = require('express');
const { Pool } = require('pg');
const app = express();

const pool = new Pool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  database: process.env.DB_NAME,
  password: process.env.DB_PASSWORD,
  port: 5432,
});

app.get('/', (req, res) => {
  res.json({ message: 'Backend is running!' });
});

app.get('/health', (req, res) => {
  pool.query('SELECT NOW()', (err, result) => {
    if (err) {
      res.status(500).json({ error: 'Database connection failed' });
      return;
    }
    res.json({ status: 'healthy', timestamp: result.rows[0].now });
  });
});

app.listen(3000, '0.0.0.0', () => {
  console.log('Backend server running on port 3000');
});
EOF

# Install dependencies and start the application
cd /home/ec2-user/backend
npm install
nohup npm start > backend.log 2>&1 &

# Create a systemd service for the backend
sudo tee /etc/systemd/system/backend.service << EOF
[Unit]
Description=Backend Node.js Application
After=network.target

[Service]
Type=simple
User=ec2-user
WorkingDirectory=/home/ec2-user/backend
Environment=DB_HOST=${db_host}
Environment=DB_USER=${db_user}
Environment=DB_NAME=${db_name}
Environment=DB_PASSWORD=${db_password}
ExecStart=/usr/bin/npm start
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Start and enable the backend service
sudo systemctl daemon-reload
sudo systemctl start backend
sudo systemctl enable backend
