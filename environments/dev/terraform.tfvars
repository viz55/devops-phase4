environment = "dev"
vpc_cidr    = "10.10.0.0/16"
az_count    = 1

instances = {
  web = { instance_type = "t3.micro", subnet_key = "public-1" }
}
