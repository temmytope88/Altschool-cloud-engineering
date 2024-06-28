resource "aws_cloudfront_distribution" "s3_distribution" {
    origin {
        domain_name    = aws_s3_bucket.conradassignbucket.bucket_regional_domain_name
        origin_id      = var.bucketname
        custom_origin_config {
            http_port              = 80
            https_port             = 443
            origin_protocol_policy = "https-only"
            origin_ssl_protocols   = ["TLSv1.2"]
        }
    }

    enabled             = true
    is_ipv6_enabled     = true
    default_root_object = "index.html"

    default_cache_behavior {
        allowed_methods = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
        cached_methods  = ["GET", "HEAD"]
        target_origin_id = var.bucketname

        forwarded_values {
            query_string = false

            cookies {
                forward = "none"
            }
        }

        viewer_protocol_policy = "allow-all"
        min_ttl                = 0
        default_ttl            = 3600
        max_ttl                = 86400
    }

    restrictions {
        geo_restriction {
            restriction_type= "none"
            locations        = []
        }
    }

    tags = {
        Environment = "production"
    }

    viewer_certificate {
        cloudfront_default_certificate = true
    }
}

resource "aws_cloudfront_origin_access_control" "origin_access_control_origin_settings" {
  name                              = aws_s3_bucket.conradassignbucket.bucket_regional_domain_name
  description                       = "origin access control for conrad bucket"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}