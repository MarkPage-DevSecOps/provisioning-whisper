variable "function_name" {
  description = "A unique name for your Lambda Function."
  type        = string
}

variable "description" {
  default     = ""
  description = "Description of what your Lambda Function does."
  type        = string
}

variable "memory_size" {
  description = "Amount of memory in MB your Lambda Function can use at runtime. Defaults to 128."
  type        = number
  default     = 128
}

variable "image_tag" {
  default     = "latest"
  description = ""
  type        = string
}

variable "lambda_timeout" {
  default     = 5
  description = "The amount of time your Lambda Function has to run in seconds. Defaults to 5"
  type        = number
}

variable "environment" {
  default     = null
  description = "The Lambda environment's configuration settings."
  type        = map(string)
}

variable "log_retention" {
  default     = 0
  description = "Specifies the number of days you want to retain log events in the specified log group. 0 indicates the logs never expire"
  type        = number
}

variable "whisper_ecr_repo" {
  description = ""
  type = string
}