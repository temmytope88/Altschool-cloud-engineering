resource "aws_acm_certificate" "cloudfront_ssl" {
  domain_name       = "temmytope.com.ng"
  validation_method = "EMAIL"
}

resource "aws_acm_certificate_validation" "cloudfront_ssl_validation" {
  certificate_arn = aws_acm_certificate.cloudfront_ssl.arn
}