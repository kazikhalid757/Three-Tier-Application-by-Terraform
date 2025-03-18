module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr          = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}

module "frontend" {
  source         = "./modules/ec2"
  vpc_id        = module.vpc.vpc_id
  subnet_id     = module.vpc.public_subnet_id
  instance_type = var.instance_type
  github_ssh_key = var.github_ssh_key
  user_data     = file("user_data_frontend.sh")
}

module "backend" {
  source         = "./modules/ec2"
  vpc_id        = module.vpc.vpc_id
  subnet_id     = module.vpc.private_subnet_id
  instance_type = var.instance_type
  github_ssh_key = var.github_ssh_key
  user_data     = file("user_data_backend.sh")
}

module "rds" {
  source       = "./modules/rds"
  vpc_id       = module.vpc.vpc_id
  subnet_id    = module.vpc.private_subnet_id
  db_username  = var.db_username
  db_password  = var.db_password
}
