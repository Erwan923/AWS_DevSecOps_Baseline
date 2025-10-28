terraform {
  required_version = ">= 1.5.0"
  
  backend "s3" {
    bucket         = "erwan-tfstate-devsecops"
    key            = "global/terraform.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
