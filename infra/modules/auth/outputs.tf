output "user_pool_id" {

  value       = aws_cognito_user_pool.users.id

  description = "ID of the Cognito User Pool"

}
 
output "user_pool_client_id" {

  value       = aws_cognito_user_pool_client.client.id

  description = "Client ID for the user pool application"

}
 
output "identity_pool_id" {

  value       = aws_cognito_identity_pool.identity_pool.id

  description = "Cognito Identity Pool ID"

}

 