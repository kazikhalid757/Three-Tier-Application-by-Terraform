resource "aws_instance" "frontend" {
  ami             = "ami-08b5b3a93ed654d19"  
  instance_type   = var.instance_type
  subnet_id       = var.public_subnet_id
  vpc_security_group_ids = [aws_security_group.frontend_sg.id]

 
  user_data = templatefile("${path.module}/user_data.sh", {
    backend_url = "http://${aws_instance.backend.private_ip}:3000"
  })

   tags = {
    Name = "Frontend-Server"
  }
}

resource "aws_security_group" "frontend_sg" {
  vpc_id = var.vpc_id

ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
