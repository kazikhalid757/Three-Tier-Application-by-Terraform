output "frontend_public_ip" {
  value = aws_instance.frontend.public_ip
}

output "frontend_sg_id" {
  description = "ID of the frontend security group"
  value       = aws_security_group.frontend_sg.id
}

output "frontend_instance_id" {
  value = aws_instance.frontend.id
}
