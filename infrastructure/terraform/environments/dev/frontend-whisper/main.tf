terraform {
  backend "s3" {
    bucket         = "terraform-whisper-s3-backend"
    key            = "frontend-whisper-dev"
    region         = "ap-southeast-1"
    encrypt        = true
    role_arn       = "arn:aws:iam::236060519813:role/Terraform-WhisperS3BackendRole"
    dynamodb_table = "terraform-whisper-s3-backend"
  }
}

provider "aws" {
  region = var.region
}

module "static-web" {
  source = "../../../modules/static-web"

  subdomain_name = var.subdomain_name
  acm_certificate_arn = var.acm_certificate_arn
}

module "route53" {
  source = "../../../modules/route53"

  domain_name = var.domain_name
  subdomain_name = var.subdomain_name
  alias_target_domain_name = module.static-web.distribution_domain_name
  alias_hosted_zone_id = module.static-web.distribution_hosted_zone_id
}