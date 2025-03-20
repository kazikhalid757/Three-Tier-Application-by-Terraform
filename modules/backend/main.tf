resource "aws_instance" "backend" {
  ami             = "ami-08b5b3a93ed654d19"  
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
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [var.frontend_sg_id]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

