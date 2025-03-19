resource "aws_instance" "backend" {
  ami             = "ami-04b4f1a9cf54c11d0"  # Ubuntu 22.04 LTS in us-east-1
  instance_type   = var.instance_type
  subnet_id       = var.private_subnet_id
  vpc_security_group_ids = [aws_security_group.backend_sg.id]
    user_data = templatefile("${path.module}/user_data.sh", {
    db_host     = var.db_host
    db_user     = var.db_user
    db_name     = var.db_name
    db_password = var.db_password
  })

  tags = {
    Name = "Backend-Server"
  }
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

