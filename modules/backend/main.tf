resource "aws_instance" "backend" {
  ami             = "ami-04b4f1a9cf54c11d0"  # Ubuntu 22.04 LTS in us-east-1
  instance_type   = var.instance_type
  subnet_id       = var.private_subnet_id
  vpc_security_group_ids = [aws_security_group.backend_sg.id]
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y nodejs npm postgresql-client
              
              echo "DB_HOST=${var.db_host}" | sudo tee -a /etc/environment
              echo "DB_USER=${var.db_user}" | sudo tee -a /etc/environment
              echo "DB_NAME=${var.db_name}" | sudo tee -a /etc/environment
              echo "DB_PASSWORD=${var.db_password}" | sudo tee -a /etc/environment
              
              source /etc/environment
              cd /home/ubuntu/backend
              npm install
              nohup npm start > backend.log 2>&1 &
              EOF
}

resource "aws_security_group" "backend_sg" {
  vpc_id = var.vpc_id

  # Allow API requests from frontend
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow from anywhere for now
  }

  # Allow backend to connect to the database
  egress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow to anywhere for now
  }
}

