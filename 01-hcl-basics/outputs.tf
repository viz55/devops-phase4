output "account_id" {
  description = "AWS account ID from the caller identity data source"
  value       = data.aws_caller_identity.current.account_id
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "azs" {
  description = "Availability zones in the primary region"
  value       = join(", ", local.az_names)
}

output "secondary_region_az_count" {
  description = "Number of AZs found through the aliased provider"
  value       = length(data.aws_availability_zones.secondary.names)
}

output "ubuntu_ami" {
  description = "Latest Ubuntu 26.04 AMI found by the data source"
  value = {
    id   = data.aws_ami.ubuntu.id
    name = data.aws_ami.ubuntu.name
  }
}

output "subnet_cidrs" {
  description = "CIDR block of each subnet, built with a for expression"
  value       = { for name, s in aws_subnet.this : name => s.cidr_block }
}

output "ingress_labels" {
  description = "Human readable list of open ports"
  value       = [for p in var.ingress_ports : format("tcp/%d", p)]
}

output "settings_summary" {
  description = "Planned compute settings from the object variable"
  value       = format("%s with %d GB disk", var.settings.instance_type, var.settings.volume_gb)
}

output "igw_id" {
  description = "Internet gateway ID, or null when it is not created"
  value       = try(aws_internet_gateway.main[0].id, null)
}

output "precedence_value" {
  description = "Winning value in the variable precedence demo"
  value       = var.precedence_demo
}

output "db_connection" {
  description = "Example connection string that contains a secret"
  value       = "mysql://admin:${var.db_password}@db.internal:3306/app"
  sensitive   = true
}
