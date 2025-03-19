output "backend_private_ip" {
  value = aws_instance.backend.private_ip
}

output "backend_sg_id" {
  description = "ID of the backend security group"
  value       = aws_security_group.backend_sg.id
}
