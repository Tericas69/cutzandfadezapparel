variable "app_name" {
  type        = string
  description = "Base application name"
}
 
variable "environment" {
  type        = string
  description = "Deployment environment (dev or prod)"
}
 
variable "tags" {
  type        = map(string)
  description = "Common tags for resources"
}