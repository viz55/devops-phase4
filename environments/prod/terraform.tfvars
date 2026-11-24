environment       = "prod"
vpc_cidr          = "10.30.0.0/16"
az_count          = 2
protect_instances = true

instances = {
  web-a = { instance_type = "t3.small", subnet_key = "public-1" }
  web-b = { instance_type = "t3.small", subnet_key = "public-2" }
}
