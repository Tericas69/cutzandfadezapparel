output "products_table_arn" {

  value       = aws_dynamodb_table.products.arn

  description = "ARN of the products table"

}
 
output "orders_table_arn" {

  value       = aws_dynamodb_table.orders.arn

  description = "ARN of the orders table"

}

 