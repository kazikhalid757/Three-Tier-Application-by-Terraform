variable "vpc_id" {
  description = "VPC ID where the frontend instance will be created"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet ID where the frontend instance will be created"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where the frontend instance will be created"
  type        = string
}

variable "backend_private_ip" {
  description = "Private IP of the backend instance"
  type        = string
}

