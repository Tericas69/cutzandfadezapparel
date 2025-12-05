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

 
variable "products_table_name" {
  type = string
}
 
variable "orders_table_name" {
  type = string
}
 
variable "products_table_arn" {
  type = string
}
 
variable "orders_table_arn" {
  type = string
}
