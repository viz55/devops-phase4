resource "aws_security_group" "web" {
  name_prefix = "${var.name_prefix}-web-"
  description = var.description
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.name_prefix}-web-sg"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_ingress_rule" "web" {
  for_each = toset([for p in var.web_ports : tostring(p)])

  security_group_id = aws_security_group.web.id
  description       = "Allow TCP ${each.value} from anywhere"
  cidr_ipv4         = var.web_ingress_cidr
  ip_protocol       = "tcp"
  from_port         = tonumber(each.value)
  to_port           = tonumber(each.value)

  tags = {
    Name = "${var.name_prefix}-web-in-${each.value}"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.web.id
  description       = var.ssh_description
  cidr_ipv4         = var.ssh_allowed_cidr
  ip_protocol       = "tcp"
  from_port         = var.ssh_port
  to_port           = var.ssh_port

  tags = {
    Name = "${var.name_prefix}-ssh-in"
  }
}

resource "aws_vpc_security_group_egress_rule" "web" {
  for_each = toset([for p in var.egress_ports : tostring(p)])

  security_group_id = aws_security_group.web.id
  description       = "Allow outbound TCP ${each.value} for package and image downloads"
  cidr_ipv4         = var.egress_cidr
  ip_protocol       = "tcp"
  from_port         = tonumber(each.value)
  to_port           = tonumber(each.value)

  tags = {
    Name = "${var.name_prefix}-web-out-${each.value}"
  }
}
