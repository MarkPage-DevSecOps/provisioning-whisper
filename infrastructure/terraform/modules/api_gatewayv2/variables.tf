variable "lambda_arn" {
  description = "ARN of the api lambda that has to be invoked for incoming api request."
  type        = string
}

variable "api_gateway_description" {
  description = "Description for the api gateway."
  type        = string
}

variable "lambda_invoke_arn" {
  description = "Invocation ARN of the api lambda that has to be invoked for incoming api request."
  type        = string
}

variable "certificate_arn" {
  description = ""
  type        = string
}

variable "apigateway_name" {
  description = ""
  type        = string
}

variable "api_domain_name" {
  description = ""
  type        = string
}