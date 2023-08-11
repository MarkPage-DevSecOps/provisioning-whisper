resource "aws_lambda_function" "whisper_function" {
  function_name = var.function_name
  description   = var.description
  memory_size   = var.memory_size
  timeout       = var.lambda_timeout
  image_uri     = "${data.aws_ecr_repository.whisper_ecr_repo.repository_url}:${var.image_tag}"
  package_type  = "Image"

  role = aws_iam_role.whisper_function_role.arn

  dynamic "environment" {
    for_each = var.environment == null ? [] : [var.environment]
    content {
      variables = var.environment
    }
  }
}