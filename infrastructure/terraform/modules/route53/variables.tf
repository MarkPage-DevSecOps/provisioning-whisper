variable "source_domain_name" {
  description = "Source domain for route53 A record."
  type        = string
}

variable "alias_target_domain_name" {
  description = ""
  type        = string
}

variable "alias_hosted_zone_id" {
  description = ""
  type = string
}

variable "domain_name" {
  description = ""
  type = string
}