resource "aws_lambda_permission" "tg_api_gateway_module_api" {
  statement_id  = "AllowExecutionFromAPIGatewayV2Integration"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.whisper-api.execution_arn}/*/*"
}