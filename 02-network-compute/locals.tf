locals {
  name_prefix = "${var.project}-${var.environment}"
  az_names    = slice(data.aws_availability_zones.available.names, 0, 2)

  common_tags = {
    Project     = var.project
    Environment = var.environment
    Owner       = var.owner
    ManagedBy   = "terraform"
  }
}
