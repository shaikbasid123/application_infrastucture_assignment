provider "aws" {
  region = "us-west-2"  # Change as needed
}

module "vpc" {
  source = "./modules/vpc"
}

module "eks" {
  source       = "./modules/eks"
  vpc_id       = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
}

module "rds" {
  source       = "./modules/rds"
  vpc_id       = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
}
