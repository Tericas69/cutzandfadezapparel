variable "app_name" {

  description = "Base application name"

  type        = string

}
 
variable "environment" {

  description = "Deployment environment (dev or prod)"

  type        = string

}
 
variable "tags" {

  description = "Common tags for API resources"

  type        = map(string)

}

 
