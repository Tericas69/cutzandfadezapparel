locals {
  user_pool_name = "${var.app_name}-${var.environment}-user-pool"
}
 
resource "aws_cognito_user_pool" "users" {
  name = local.user_pool_name
 
  username_attributes = ["email"]
 
  auto_verified_attributes = ["email"]
 
  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_numbers   = true
    require_symbols   = false
    require_uppercase = true
  }
 
  mfa_configuration = "OFF"
 
  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }
 
  tags = var.tags
}
 
resource "aws_cognito_user_pool_client" "client" {
  name         = "${var.app_name}-${var.environment}-client"
  user_pool_id = aws_cognito_user_pool.users.id
 
  generate_secret = false
 
  allowed_oauth_flows             = ["implicit", "code"]
  allowed_oauth_scopes            = ["email", "openid", "profile"]
  allowed_oauth_flows_user_pool_client = true
 
  callback_urls = ["http://localhost:3000"] # Placeholder for local dev
  logout_urls   = ["http://localhost:3000"]
 
  supported_identity_providers = ["COGNITO"]
}
 
resource "aws_cognito_identity_pool" "identity_pool" {
  identity_pool_name               = "${var.app_name}-${var.environment}-identity-pool"
  allow_unauthenticated_identities = false
 
  cognito_identity_providers {
    client_id               = aws_cognito_user_pool_client.client.id
    provider_name           = aws_cognito_user_pool.users.endpoint
    server_side_token_check = false
  }
}
 
resource "aws_iam_role" "authenticated_role" {
  name = "${var.app_name}-${var.environment}-authenticated-role"
 
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = "cognito-identity.amazonaws.com"
        }
        Action = "sts:AssumeRoleWithWebIdentity"
 
        Condition = {
          "StringEquals" = {
            "cognito-identity.amazonaws.com:aud" = aws_cognito_identity_pool.identity_pool.id
          }
          "ForAnyValue:StringLike" = {
            "cognito-identity.amazonaws.com:amr" = "authenticated"
          }
        }
      }
    ]
  })
}
 
resource "aws_iam_role_policy" "authenticated_policy" {
  name = "authenticated-policy"
  role = aws_iam_role.authenticated_role.id
 
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["mobileanalytics:PutEvents", "cognito-sync:*", "cognito-identity:*"]
        Resource = "*"
      }
    ]
  })
}