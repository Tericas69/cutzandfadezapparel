locals {

  bucket_name = "${var.app_name}-${var.environment}-frontend"

}
 
resource "aws_s3_bucket" "frontend" {

  bucket = local.bucket_name

}
 
resource "aws_s3_bucket_public_access_block" "frontend" {

  bucket                  = aws_s3_bucket.frontend.id

  block_public_acls       = true

  block_public_policy     = true

  ignore_public_acls      = true

  restrict_public_buckets = true

}
 
resource "aws_cloudfront_origin_access_control" "oac" {

  name                              = "${var.app_name}-${var.environment}-oac"

  description                       = "OAC for secure frontend delivery"

  origin_access_control_origin_type = "s3"

  signing_behavior                  = "always"

  signing_protocol                  = "sigv4"

}
 
resource "aws_cloudfront_distribution" "cdn" {

  enabled = true

  default_root_object = "index.html"
 
  origin {

    domain_name = aws_s3_bucket.frontend.bucket_regional_domain_name

    origin_id   = "frontend-s3"
 
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id

  }
 
  default_cache_behavior {

    target_origin_id = "frontend-s3"

    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD"]

    cached_methods  = ["GET", "HEAD"]
 
    forwarded_values {

      query_string = false

      cookies {

        forward = "none"

      }

    }

  }
 
  restrictions {

    geo_restriction {

      restriction_type = "none"

    }

  }
 
  viewer_certificate {

    cloudfront_default_certificate = true

  }
 
  tags = var.tags

}

 