variable "environment" {
  description = "Deployment environment (dev or prod)"
  type        = string
  default     = "dev"
}
 
variable "aws_region" {
  description = "AWS region to deploy resources into"
  type        = string
  default     = "us-east-1"
}
 
variable "app_name" {
  description = "Base name for Cutz & Fadez resources"
  type        = string
  default     = "cutz-fadez"
}
 
variable "domain_name" {
  description = "Primary domain name for the storefront (optional for now)"
  type        = string
  default     = ""
}
 
variable "tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default = {
    Project     = "CutzAndFadezApparel"
    Owner       = "TericaShepard"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}