resource "aws_instance" "app" {
  ami             = "ami-08b5b3a93ed654d19"
  instance_type   = var.instance_type
  subnet_id       = var.subnet_id
  key_name        = "my-key"
  user_data       = var.user_data

  tags = {
    Name = "AppInstance"
  }
}
