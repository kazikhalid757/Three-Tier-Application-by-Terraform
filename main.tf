module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr          = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  public_subnet_cidr_2 = var.public_subnet_cidr_2
  private_subnet_cidr = var.private_subnet_cidr
  private_subnet_cidr_2 = var.private_subnet_cidr_2
}

module "backend" {
  source          = "./modules/backend"
  instance_type   = var.instance_type
  vpc_id          = module.vpc.vpc_id
  private_subnet_id = module.vpc.private_subnet_id
  subnet_id       = module.vpc.private_subnet_id
  db_host         = module.rds.db_endpoint
  db_user         = var.db_user
  db_password     = var.db_password
  db_name         = var.db_name
  frontend_sg_id  = module.frontend.frontend_sg_id
}

module "frontend" {
  source            = "./modules/frontend"
  instance_type     = var.instance_type
  vpc_id            = module.vpc.vpc_id
  public_subnet_id  = module.vpc.public_subnet_id
  subnet_id         = module.vpc.public_subnet_id
  backend_private_ip = module.backend.backend_private_ip
}

module "rds" {
  source          = "./modules/rds"
  vpc_id          = module.vpc.vpc_id
  private_subnet_ids = [module.vpc.private_subnet_id, module.vpc.private_subnet_id_2]
  db_user         = var.db_user
  db_password     = var.db_password
  db_name         = var.db_name
  backend_sg_id   = module.backend.backend_sg_id
}

module "alb" {
  source             = "./modules/alb"
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = [module.vpc.public_subnet_id, module.vpc.public_subnet_id_2]
  frontend_instance_id = module.frontend.frontend_instance_id 
}

