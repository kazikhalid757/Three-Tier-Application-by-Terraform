resource "aws_instance" "frontend" {
  ami             = "ami-04b4f1a9cf54c11d0"  # Ubuntu 22.04 LTS in us-east-1
  instance_type   = var.instance_type
  subnet_id       = var.public_subnet_id
  vpc_security_group_ids = [aws_security_group.frontend_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y nginx
              systemctl start nginx
              EOF
}

resource "aws_security_group" "frontend_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
