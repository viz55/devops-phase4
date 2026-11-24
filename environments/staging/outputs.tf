output "environment" {
  description = "Name of this environment"
  value       = var.environment
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "instance_ids" {
  description = "IDs of the instances"
  value       = module.compute.instance_ids
}

output "public_ips" {
  description = "Public IP of each instance"
  value       = module.compute.public_ips
}

output "website_urls" {
  description = "URL of the nginx page on each instance"
  value       = { for k, ip in module.compute.public_ips : k => "http://${ip}" }
}

output "ssh_commands" {
  description = "Ready-to-use SSH command for each instance"
  value       = { for k, ip in module.compute.public_ips : k => "ssh -i ${var.ssh_private_key_path} ${var.default_user}@${ip}" }
}
