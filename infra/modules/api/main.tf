locals {
  function_name = "${var.app_name}-${var.environment}-api"
}
 
resource "aws_iam_role" "lambda_role" {
  name = "${local.function_name}-role"
 
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}
 
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
 
resource "aws_lambda_function" "backend" {
  function_name = local.function_name
  role          = aws_iam_role.lambda_role.arn
  runtime       = "nodejs18.x"
  handler       = "index.handler"
 
  filename         = "build/backend.zip"
  source_code_hash = filebase64sha256("build/backend.zip")
 
  environment {
    variables = {
      APP_ENV = var.environment
    }
  }
 
  tags = var.tags
}