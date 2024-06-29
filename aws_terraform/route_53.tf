#create a hosted Zone
# resource "aws_route53_zone" "cloudfront_s3" {
#   name = var.domain_name
# }

#retrieve the data of a hostzone already created
data "aws_route53_zone" "main" {
  name = var.domain_name # Replace with your domain name
}

#add cloudfront distribution to the host zone
resource "aws_route53_record" "cloudfront_distribution" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "bucket.${var.domain_name}" # Replace with your domain/subdomain
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}