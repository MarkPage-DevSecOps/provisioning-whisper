resource "aws_s3_bucket" "site_origin" {
  bucket        = "whisper-service-frontend"
  tags = {
    environment = "dev"
  }
}

resource "aws_s3_bucket_public_access_block" "site_origin" {
  bucket = aws_s3_bucket.site_origin.bucket

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "site_origin" {
  bucket = aws_s3_bucket.site_origin.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "site_origin" {
  bucket = aws_s3_bucket.site_origin.bucket
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "site_origin" {
  depends_on = [ 
    data.aws_iam_policy_document.site_origin
  ]

  bucket = aws_s3_bucket.site_origin.id
  policy = data.aws_iam_policy_document.site_origin.json
}

data "aws_iam_policy_document" "site_origin" {
  depends_on = [ 
    aws_cloudfront_distribution.site_access,
    aws_s3_bucket.site_origin
  ]

  statement {
    sid = "s3_cloudfront_static_website"
    effect = "Allow"
    actions = [
      "s3:GetObject"
    ]

    principals {
      identifiers = ["cloudfront.amazonaws.com"]
      type = "Service"
    }

    resources = [
      "arn:aws:s3:::${aws_s3_bucket.site_origin.bucket}/*"
    ]

    condition {
      test = "StringEquals"
      variable = "AWS:SourceArn"

      values = [ aws_cloudfront_distribution.site_access.arn ]
    }
  }
}