locals {
  name_prefix = "${var.project}-${var.environment}"
  az_names    = slice(data.aws_availability_zones.available.names, 0, var.az_count)

  common_tags = {
    Project     = var.project
    Environment = var.environment
    Owner       = var.owner
    ManagedBy   = "terraform"
  }
}

data "aws_availability_zones" "available" {
  state = "available"

  filter {
    name   = "zone-name"
    values = var.availability_zones
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = [var.ami_name_pattern]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

module "vpc" {
  source = "../../modules/vpc"

  name_prefix = local.name_prefix
  vpc_cidr    = var.vpc_cidr
  az_names    = local.az_names
}

module "security" {
  source = "../../modules/security"

  name_prefix      = local.name_prefix
  vpc_id           = module.vpc.vpc_id
  ssh_allowed_cidr = var.ssh_allowed_cidr
  web_ports        = var.web_ports
}

module "compute" {
  source = "../../modules/compute"

  name_prefix        = local.name_prefix
  ami_id             = data.aws_ami.ubuntu.id
  subnet_ids         = module.vpc.public_subnet_ids
  security_group_ids = [module.security.web_security_group_id]
  ssh_public_key     = var.ssh_public_key
  instances          = var.instances
  protect_instances  = var.protect_instances
  default_user       = var.default_user
  nginx_tag          = var.nginx_tag
  common_tags        = local.common_tags
}
