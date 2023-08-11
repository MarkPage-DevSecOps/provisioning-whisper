data "aws_route53_zone" "whisper-zone" {
  name = var.domain_name
  private_zone = false
}

resource "aws_route53_record" "whisper-record" {
  name    = var.source_domain_name
  type    = "A"
  zone_id = data.aws_route53_zone.whisper-zone.zone_id

  alias {
    name                   = var.alias_target_domain_name
    zone_id                = var.alias_hosted_zone_id
    evaluate_target_health = false
  }
}