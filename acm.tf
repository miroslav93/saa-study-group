resource "aws_acm_certificate" "aws_banjaluka_cert" {
  provider                  = aws.accountA-us-east-1
  domain_name               = "awsbanjaluka.com"
  validation_method         = "DNS"
  subject_alternative_names = ["www.awsbanjaluka.com"]

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "awsbanjaluka-cert"
  }
}

resource "aws_route53_record" "aws_banjaluka_cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.aws_banjaluka_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id = aws_route53_zone.aws_banjaluka.zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 300
}

resource "aws_acm_certificate_validation" "aws_banjaluka_cert_validation" {
  provider = aws.accountA-us-east-1
  certificate_arn         = aws_acm_certificate.aws_banjaluka_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.aws_banjaluka_cert_validation : record.fqdn]
}
