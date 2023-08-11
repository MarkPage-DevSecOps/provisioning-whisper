output "domain_name" {
  value = aws_apigatewayv2_domain_name.api_domain_name.domain_name
}

output "target_domain_name" {
  value = aws_apigatewayv2_domain_name.api_domain_name.domain_name_configuration[0].target_domain_name
}

output "hosted_zone_id" {
  value = aws_apigatewayv2_domain_name.api_domain_name.domain_name_configuration[0].hosted_zone_id
}

output "whisper_base_url" {
  value = aws_apigatewayv2_stage.whisper-api-stage.invoke_url
}