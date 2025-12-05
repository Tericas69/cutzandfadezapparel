output "bucket_name" {
  description = "Name of the S3 bucket for the frontend"
  value       = aws_s3_bucket.frontend.bucket
}
 
output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID"
  value       = aws_cloudfront_distribution.cdn.id
}
 
output "cloudfront_domain_name" {
  description = "CloudFront domain name"
  value       = aws_cloudfront_distribution.cdn.domain_name
}