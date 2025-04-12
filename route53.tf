resource "aws_route53_zone" "aws_banjaluka" {
  name = "awsbanjaluka.com"
}

resource "aws_route53_record" "aws_bl_a" {
  zone_id = aws_route53_zone.aws_banjaluka.zone_id
  name    = "awsbanjaluka.com"
  type    = "A"
  
  alias {
    name                   = aws_lb.study_lb.dns_name
    zone_id                = aws_lb.study_lb.zone_id
    evaluate_target_health = true
  }

  depends_on = [aws_lb.study_lb]
}

resource "aws_route53_record" "aws_bl_a_www" {
  zone_id = aws_route53_zone.aws_banjaluka.zone_id
  name    = "www.awsbanjaluka.com"
  type    = "A"

  alias {
    name                   = aws_lb.study_lb.dns_name
    zone_id                = aws_lb.study_lb.zone_id
    evaluate_target_health = true
  }

  depends_on = [aws_lb.study_lb]
}