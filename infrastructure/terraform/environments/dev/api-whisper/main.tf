terraform {
  backend "s3" {
    bucket         = "terraform-whisper-s3-backend"
    key            = "api-whisper-dev"
    region         = "ap-southeast-1"
    encrypt        = true
    role_arn       = "arn:aws:iam::236060519813:role/Terraform-WhisperS3BackendRole"
    dynamodb_table = "terraform-whisper-s3-backend"
  }
}

provider "aws" {
  region = var.region
}

module "lambda" {
  source = "../../../modules/lambda_image"

  function_name  = "my_function"  
  memory_size    = 1500
  lambda_timeout = 120
  image_tag      = var.image_tag
  whisper_ecr_repo = var.whisper_ecr_repo
  environment = {
    APP_NAME   = "Lambda_4_api_gateway_example"
  }
}

module "api_gatewayv2" {
  source = "../../../modules/api_gatewayv2"

  lambda_arn = module.lambda.arn
  lambda_invoke_arn = module.lambda.invoke_arn
  certificate_arn = var.acm_certificate_arn
  api_gateway_description = "An example API Gateway"
  apigateway_name = "whisper-http-api"
  api_domain_name = var.subdomain_name
}

module "route53" {
  source = "../../../modules/route53"

  subdomain_name = module.api_gatewayv2.domain_name
  alias_target_domain_name = module.api_gatewayv2.target_domain_name
  alias_hosted_zone_id = module.api_gatewayv2.hosted_zone_id
  domain_name = var.domain_name
}