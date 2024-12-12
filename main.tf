module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  web_subnet_cidr = var.web_subnet_cidr
  app_subnet_cidr = var.app_subnet_cidr
}




module "eks" {
  source          = "./modules/eks"
  cluster_name    = var.cluster_name
  app_subnet_ids  = module.vpc.app_tier_subnet_id # Private subnets
  web_subnet_ids  = module.vpc.web_tier_subnet_id # Public subnets

}




