output "get_bucket_id" {
  value = aws_s3_bucket.conradassignbucket.id
}

output "region_domain_name" {
  value = aws_s3_bucket.conradassignbucket.bucket_regional_domain_name
}

output "try" {
  value = aws_cloudfront_distribution.s3_distribution.arn
}

output "domain_name" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name

}


