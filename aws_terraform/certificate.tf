#creates the ACM
resource "aws_acm_certificate" "cloudfront_ssl" {
  domain_name       = var.domain_name
  validation_method = "DNS"
}

#DNS validation with route53
resource "aws_route53_record" "example" {
  for_each = {
    for dvo in aws_acm_certificate.cloudfront_ssl.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.main.zone_id
}

resource "aws_acm_certificate_validation" "example" {
  certificate_arn         = aws_acm_certificate.cloudfront_ssl.arn
  validation_record_fqdns = [for record in aws_route53_record.example : record.fqdn]
}

resource "aws_acm_certificate_validation" "cloudfront_ssl_validation" {
  certificate_arn = aws_acm_certificate.cloudfront_ssl.arn
}