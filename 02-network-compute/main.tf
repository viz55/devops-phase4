module "vpc" {
  source = "../modules/vpc"

  name_prefix = local.name_prefix
  vpc_cidr    = var.vpc_cidr
  az_names    = local.az_names
}

module "security" {
  source = "../modules/security"

  name_prefix      = local.name_prefix
  vpc_id           = module.vpc.vpc_id
  ssh_allowed_cidr = var.ssh_allowed_cidr
  web_ports        = var.web_ports
  ssh_description  = "SSH from my laptop only"
}

module "compute" {
  source = "../modules/compute"

  name_prefix                 = local.name_prefix
  ami_id                      = data.aws_ami.ubuntu.id
  subnet_ids                  = module.vpc.public_subnet_ids
  security_group_ids          = [module.security.web_security_group_id]
  ssh_public_key              = var.ssh_public_key
  default_user                = var.default_user
  nginx_tag                   = var.nginx_tag
  common_tags                 = local.common_tags
  extra_tags                  = {}
  detailed_monitoring         = true
  user_data_replace_on_change = true
  associate_public_ip         = false

  instances = {
    web = { instance_type = var.instance_type, subnet_key = "public-1" }
  }
}
