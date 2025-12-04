terraform {

  required_version = ">= 1.6.0"
 
  required_providers {

    aws = {

      source  = "hashicorp/aws"

      version = "~> 5.0"

    }

  }

}
 
provider "aws" {

  region = var.aws_region

}
 
# ---------------------------

# Core modules for the platform

# ---------------------------
 
module "web" {

  source      = "./modules/web"

  app_name    = var.app_name

  environment = var.environment

  tags        = var.tags

}
 
module "api" {

  source      = "./modules/api"

  app_name    = var.app_name

  environment = var.environment

  tags        = var.tags

}
 
module "auth" {

  source      = "./modules/auth"

  app_name    = var.app_name

  environment = var.environment

  tags        = var.tags

}
 
module "db" {

  source      = "./modules/db"

  app_name    = var.app_name

  environment = var.environment

  tags        = var.tags

}
 
module "analytics" {

  source      = "./modules/analytics"

  app_name    = var.app_name

  environment = var.environment

  tags        = var.tags

}

 