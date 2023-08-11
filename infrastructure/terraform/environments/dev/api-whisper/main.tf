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
  region = "ap-southeast-1"
}

module "lambda" {
  source = "../../../modules/lambda_image"

  function_name  = "my_function"  
  memory_size    = 1500
  lambda_timeout = 120
  image_tag      = "latest"
  whisper_ecr_repo = "docker-lambda"
  environment = {
    APP_NAME   = "Lambda_4_api_gateway_example"
  }
}

module "api_gatewayv2" {
  source = "../../../modules/api_gatewayv2"

  lambda_arn = module.lambda.arn
  lambda_invoke_arn = module.lambda.invoke_arn
  certificate_arn = "arn:aws:acm:ap-southeast-1:236060519813:certificate/792f2902-0c70-40af-b238-58e629b86a2a"
  api_gateway_description = "An example API Gateway"
  apigateway_name = "whisper-http-api"
  api_domain_name = "api-whisper.markpage2k1.dev"
}

module "route53" {
  source = "../../../modules/route53"

  source_domain_name = module.api_gatewayv2.domain_name
  alias_target_domain_name = module.api_gatewayv2.target_domain_name
  alias_hosted_zone_id = module.api_gatewayv2.hosted_zone_id
  domain_name = "markpage2k1.dev"
}