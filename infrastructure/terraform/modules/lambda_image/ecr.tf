data "aws_ecr_repository" "whisper_ecr_repo" {
  name = var.whisper_ecr_repo
}