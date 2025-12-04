output "frontend_bucket_name" {

  description = "S3 bucket hosting the static frontend"

  value       = module.web.bucket_name

}
 
output "cloudfront_distribution_id" {

  description = "CloudFront distribution used for the storefront"

  value       = module.web.cloudfront_distribution_id

}
 
output "api_gateway_invoke_url" {

  description = "Base URL for the public API Gateway"

  value       = module.api.invoke_url

}
 
output "cognito_user_pool_id" {

  description = "ID of the Cognito user pool for customer auth"

  value       = module.auth.user_pool_id

}
 
output "dynamodb_table_name" {

  description = "Primary DynamoDB table used for orders/products"

  value       = module.db.table_name

}

 