output "arn" {
  value = aws_lambda_function.whisper_function.arn
  description = "Lambda ARN"
}

output "invoke_arn" {
  value       = aws_lambda_function.whisper_function.invoke_arn
  description = "ARN to invoke the lambda method"
}