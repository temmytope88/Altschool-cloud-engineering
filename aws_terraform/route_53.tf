resource "aws_route53_zone" "cloudfront_s3" {
  name = "temmytope.com.ng"
}

resource "aws_route53_record" "cloudfront_distribution" {
  zone_id = aws_route53_zone.cloudfront_s3.zone_id
  name    = "bucket.temmytope.com.ng" # Replace with your domain/subdomain
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}