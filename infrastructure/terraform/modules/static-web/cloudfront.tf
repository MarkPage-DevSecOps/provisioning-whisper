resource "aws_cloudfront_origin_access_control" "site_access" {
  name = "security_pillar100_cf_s3_oac"
  origin_access_control_origin_type = "s3"
  signing_behavior = "always"
  signing_protocol = "sigv4"
}

resource "aws_cloudfront_distribution" "site_access" {
  depends_on = [ 
    aws_s3_bucket.site_origin,
    aws_cloudfront_origin_access_control.site_access
  ]

  enabled = true
  default_root_object = "index.html"

  origin {
    domain_name = aws_s3_bucket.site_origin.bucket_domain_name
    origin_id   = aws_s3_bucket.site_origin.id
    origin_access_control_id = aws_cloudfront_origin_access_control.site_access.id
  }

  default_cache_behavior {
    allowed_methods        = [ "GET", "HEAD" ]
    cached_methods         = [ "GET", "HEAD" ]
    target_origin_id       = aws_s3_bucket.site_origin.id
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  aliases = [ 
    var.subdomain_name
  ]

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = [ "VN" ]
    }
  }

  viewer_certificate {
    acm_certificate_arn = var.acm_certificate_arn
    ssl_support_method  = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
    cloudfront_default_certificate = false
  }
}