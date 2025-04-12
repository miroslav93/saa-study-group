resource "aws_cloudfront_distribution" "study_distribution" {
  provider = aws.accountA

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Study Group Distribution"
  default_root_object = ""

  aliases = ["awsbanjaluka.com", "www.awsbanjaluka.com"]

  origin {
    domain_name = aws_lb.study_lb.dns_name
    origin_id   = "alb-origin"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "alb-origin"

    forwarded_values {
      query_string = true
      cookies {
        forward = "all"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_100"

  viewer_certificate {
    acm_certificate_arn            = aws_acm_certificate.aws_banjaluka_cert.arn
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = "TLSv1.2_2021"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Environment = "production"
  }

    depends_on = [
        aws_lb.study_lb,
        aws_acm_certificate_validation.aws_banjaluka_cert_validation,
        aws_acm_certificate.aws_banjaluka_cert
    ]
}


