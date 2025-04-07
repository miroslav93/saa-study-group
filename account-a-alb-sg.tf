data "aws_region" "current" {}
output my-region {
  value = data.aws_region.current.name
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.stydygroup_vpc.id
  provider = aws.accountA


  tags = {
    Name = "allow_tls"
  }

  depends_on = [
    aws_vpc.stydygroup_vpc,
  ]
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = aws_vpc.stydygroup_vpc.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
  provider = aws.accountA
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  provider = aws.accountA
}