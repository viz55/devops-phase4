moved {
  from = aws_vpc.main
  to   = module.vpc.aws_vpc.main
}

moved {
  from = aws_internet_gateway.main
  to   = module.vpc.aws_internet_gateway.main
}

moved {
  from = aws_subnet.public
  to   = module.vpc.aws_subnet.public
}

moved {
  from = aws_subnet.private
  to   = module.vpc.aws_subnet.private
}

moved {
  from = aws_route_table.public
  to   = module.vpc.aws_route_table.public
}

moved {
  from = aws_route_table.private
  to   = module.vpc.aws_route_table.private
}

moved {
  from = aws_route_table_association.public
  to   = module.vpc.aws_route_table_association.public
}

moved {
  from = aws_route_table_association.private
  to   = module.vpc.aws_route_table_association.private
}

moved {
  from = aws_default_security_group.default
  to   = module.vpc.aws_default_security_group.default
}

moved {
  from = aws_security_group.web
  to   = module.security.aws_security_group.web
}

moved {
  from = aws_vpc_security_group_ingress_rule.web
  to   = module.security.aws_vpc_security_group_ingress_rule.web
}

moved {
  from = aws_vpc_security_group_ingress_rule.ssh
  to   = module.security.aws_vpc_security_group_ingress_rule.ssh
}

moved {
  from = aws_vpc_security_group_egress_rule.web
  to   = module.security.aws_vpc_security_group_egress_rule.web
}

moved {
  from = aws_key_pair.lab
  to   = module.compute.aws_key_pair.lab
}

moved {
  from = aws_instance.web
  to   = module.compute.aws_instance.web["web"]
}
