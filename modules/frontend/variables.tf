variable "vpc_id" {
  description = "VPC ID where the frontend instance will be created"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet ID for the frontend instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "subnet_id" {}

