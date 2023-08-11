resource "aws_iam_role" "whisper_function_role" {
  name = "whisper-function-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Principal = {
        Service = "lambda.amazonaws.com"
      },
      Effect = "Allow",
    }],
  })
}

resource "aws_iam_role_policy" "whisper_function_policy" {
  name   = "whisper-function-policy"
  role   = aws_iam_role.whisper_function_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect   = "Allow",
      Action   = "logs:CreateLogGroup",
      Resource = "arn:aws:logs:ap-southeast-1:236060519813:*"
    },
    {
      Effect  = "Allow",
      Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
      ],
      Resource = [
          "arn:aws:logs:ap-southeast-1:236060519813:log-group:/aws/lambda/${var.function_name}:*"
      ]
    }],
  })
}