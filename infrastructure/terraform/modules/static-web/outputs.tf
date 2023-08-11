output "distribution_domain_name" {
    value = aws_cloudfront_distribution.site_access.domain_name
}

output "distribution_hosted_zone_id" {
    value = aws_cloudfront_distribution.site_access.hosted_zone_id
}