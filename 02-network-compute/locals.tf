locals {
  name_prefix = "${var.project}-${var.environment}"
  az_names    = slice(data.aws_availability_zones.available.names, 0, 2)

  common_tags = {
    Project     = var.project
    Environment = var.environment
    Owner       = var.owner
    ManagedBy   = "terraform"
  }

  public_subnets = {
    for i, az in local.az_names : "public-${i + 1}" => {
      az   = az
      cidr = cidrsubnet(var.vpc_cidr, 8, i)
    }
  }

  private_subnets = {
    for i, az in local.az_names : "private-${i + 1}" => {
      az   = az
      cidr = cidrsubnet(var.vpc_cidr, 8, i + 10)
    }
  }
}
