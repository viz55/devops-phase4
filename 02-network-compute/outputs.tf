output "public_ip" {
  description = "Public IPv4 address of the web server"
  value       = module.compute.public_ips["web"]
}

output "instance_id" {
  description = "ID of the web server instance"
  value       = module.compute.instances["web"].id
}

output "ssh_command" {
  description = "Ready-to-use SSH command"
  value       = "ssh -i ${var.ssh_private_key_path} ${var.default_user}@${module.compute.public_ips["web"]}"
}

output "website_url" {
  description = "URL of the nginx page"
  value       = "http://${module.compute.public_ips["web"]}"
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = values(module.vpc.public_subnet_ids)
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = values(module.vpc.private_subnet_ids)
}
