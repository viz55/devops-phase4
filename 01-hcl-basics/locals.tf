locals {
  name_prefix = "${var.project}-${var.environment}"
  is_prod     = var.environment == "prod"
  az_names    = data.aws_availability_zones.available.names

  common_tags = {
    Project     = var.project
    Environment = var.environment
    Owner       = var.owner
    ManagedBy   = "terraform"
  }
}
