module "auth" {
  source      = "./modules/auth"
  app_name    = var.app_name
  environment = var.environment
  tags        = var.tags
}