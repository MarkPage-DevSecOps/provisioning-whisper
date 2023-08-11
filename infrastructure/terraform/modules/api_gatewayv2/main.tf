resource "aws_apigatewayv2_api" "whisper-api" {
  name          = var.apigateway_name
  description   = ""
  protocol_type = "HTTP"
  cors_configuration {
    allow_origins = ["https://*", "http://*"]
    allow_methods = ["POST"]
    allow_headers = ["content-type"]
    allow_credentials = true
    max_age = 300
  }
}

resource "aws_apigatewayv2_domain_name" "api_domain_name" {
  domain_name = var.api_domain_name

  domain_name_configuration {
    certificate_arn = var.certificate_arn
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }
}

resource "aws_apigatewayv2_stage" "whisper-api-stage" {
  api_id = aws_apigatewayv2_api.whisper-api.id
  name   = "$default"
  auto_deploy = true
}

resource "aws_apigatewayv2_api_mapping" "api_mapping" {
  api_id      = aws_apigatewayv2_api.whisper-api.id
  domain_name = aws_apigatewayv2_domain_name.api_domain_name.id
  stage       = aws_apigatewayv2_stage.whisper-api-stage.id
}

resource "aws_apigatewayv2_integration" "lambda_whisper" {
  api_id           = aws_apigatewayv2_api.whisper-api.id
  integration_type = "AWS_PROXY"

  connection_type        = "INTERNET"
  description            = var.api_gateway_description
  integration_method     = "POST"
  integration_uri        = var.lambda_invoke_arn
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "post-whisper-api" {
  api_id    = aws_apigatewayv2_api.whisper-api.id
  route_key = "POST /upload"
  authorization_type = "NONE" # Use JWT, AWS_IAM or CUSTOM for specific authorization
  target = "integrations/${aws_apigatewayv2_integration.lambda_whisper.id}"
}