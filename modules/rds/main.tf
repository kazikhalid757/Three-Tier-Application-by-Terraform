resource "aws_db_instance" "database" {
  allocated_storage    = 20
  engine              = "postgres"
  instance_class      = "db.t3.micro"
  username           = var.db_user
  password           = var.db_password
  db_name            = var.db_name
  publicly_accessible = false
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  
  skip_final_snapshot = true  # Skip final snapshot when destroying
  final_snapshot_identifier = "final-snapshot"  # Required if skip_final_snapshot is false
}

resource "aws_security_group" "rds_sg" {
  vpc_id = var.vpc_id

ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    security_groups = [var.backend_sg_id]  # Pass backend security group ID from variables
  }

  # Allow the database to respond to requests
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "my-db-subnet-group-${random_id.suffix.hex}"
  subnet_ids = var.private_subnet_ids
}

resource "random_id" "suffix" {
  byte_length = 4
}
