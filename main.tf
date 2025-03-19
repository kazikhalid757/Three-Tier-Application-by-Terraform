module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr          = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}

module "frontend" {
  source          = "./modules/frontend"
  instance_type   = var.instance_type
  vpc_id          = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_id
  subnet_id       = module.vpc.public_subnet_id
  user_data       = var.user_data
}

module "backend" {
  source          = "./modules/backend"
  instance_type   = var.instance_type
  vpc_id          = module.vpc.vpc_id
  private_subnet_id = module.vpc.private_subnet_id
  subnet_id       = module.vpc.private_subnet_id
  user_data       = var.user_data
  db_host         = module.rds.db_endpoint
  db_user         = var.db_user
  db_password     = var.db_password
  db_name         = var.db_name
}

module "rds" {
  source          = "./modules/rds"
  vpc_id          = module.vpc.vpc_id
  private_subnet_id = module.vpc.private_subnet_id
  private_subnet_ids = [module.vpc.private_subnet_id]
  db_user         = var.db_user
  db_password     = var.db_password
  db_name         = var.db_name
}

