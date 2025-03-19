output "frontend_ip" {
  value = module.frontend.frontend_public_ip
}

output "backend_ip" {
  value = module.backend.backend_private_ip
}

output "database_endpoint" {
  value = module.rds.db_endpoint
}
