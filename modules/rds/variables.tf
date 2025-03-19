variable "vpc_id" {
  description = "VPC ID where the RDS instance will be created"
  type        = string
}

variable "private_subnet_id" {
  description = "Private subnet ID for the RDS instance"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for the RDS instance"
  type        = list(string)
}

variable "backend_sg_id" {
  description = "Security group ID of the backend instance"
  type        = string
}

variable "db_user" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Name of the database to be created"
  type        = string
}
