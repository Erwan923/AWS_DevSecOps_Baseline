terraform {
  backend "s3" {
    bucket         = "erwan-tfstate-devsecops"
    key            = "dev/terraform.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
  required_providers {
    aws = { source = "hashicorp/aws", version = "~> 5.0" }
  }
}

provider "aws" {
  region = "eu-north-1"
  default_tags {
    tags = { Project = "DevSecOps", Environment = "dev", Owner = "erwan" }
  }
}

module "vpc" {
  source          = "../../modules/vpc"
  vpc_name        = "devsecops-dev"
  vpc_cidr        = "10.0.0.0/16"
  azs             = ["eu-north-1a", "eu-north-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
  environment     = "dev"
}

module "ecs" {
  source = "../../modules/ecs"
  
  cluster_name             = "devsecops-dev"
  vpc_id                   = module.vpc.vpc_id
  private_subnet_ids       = module.vpc.private_subnet_ids
  environment              = "dev"
  enable_container_insights = true
  
  app_name      = "demo-app"
  app_image     = "nginx:alpine"
  desired_count = 2
  cpu           = 256
  memory        = 512
}
