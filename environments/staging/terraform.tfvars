environment = "staging"
vpc_cidr    = "10.20.0.0/16"
az_count    = 2

instances = {
  web = { instance_type = "t3.small", subnet_key = "public-1" }
}
