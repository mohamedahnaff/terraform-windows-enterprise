resource "aws_security_group" "windows" {
  name        = "${local.name_prefix}-windows-sg"
  description = "Security group for private Windows EC2 instances"
  vpc_id      = aws_vpc.windows.id

  tags = {
    Name = "${local.name_prefix}-windows-sg"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "vpc_endpoints" {
  name        = "${local.name_prefix}-endpoints-sg"
  description = "Security group for Systems Manager interface endpoints"
  vpc_id      = aws_vpc.windows.id

  tags = {
    Name = "${local.name_prefix}-endpoints-sg"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_ingress_rule" "vpc_endpoints_https_from_windows" {
  security_group_id = aws_security_group.vpc_endpoints.id

  referenced_security_group_id = aws_security_group.windows.id

  description = "Allow HTTPS from Windows instances to VPC endpoints"
  ip_protocol = "tcp"
  from_port   = 443
  to_port     = 443

  tags = {
    Name = "${local.name_prefix}-endpoints-https-from-windows"
  }
}

resource "aws_vpc_security_group_egress_rule" "windows_https_to_vpc_endpoints" {
  security_group_id = aws_security_group.windows.id

  referenced_security_group_id = aws_security_group.vpc_endpoints.id

  description = "Allow HTTPS from Windows instances to VPC endpoints"
  ip_protocol = "tcp"
  from_port   = 443
  to_port     = 443

  tags = {
    Name = "${local.name_prefix}-windows-https-to-endpoints"
  }
}
