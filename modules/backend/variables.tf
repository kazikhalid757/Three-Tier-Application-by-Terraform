variable "instance_type" {}
variable "subnet_id" {}
variable "user_data" {}

variable "vpc_id" {
  description = "VPC ID where the backend instance will be created"
  type        = string
}

variable "private_subnet_id" {
  description = "Private subnet ID for the backend instance"
  type        = string
}

variable "db_host" {
  description = "Database host address"
  type        = string
}

variable "db_user" {
  description = "Database username"
  type        = string
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}
