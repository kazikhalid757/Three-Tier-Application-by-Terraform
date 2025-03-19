output "rds_sg_id" {
  description = "ID of the RDS security group"
  value       = aws_security_group.rds_sg.id
}

output "db_endpoint" {
  description = "The connection endpoint for the RDS instance"
  value       = aws_db_instance.database.endpoint
}
