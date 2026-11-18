output "public_ip" {
  description = "Public IPv4 address of the web server"
  value       = aws_instance.web.public_ip
}

output "instance_id" {
  description = "ID of the web server instance"
  value       = aws_instance.web.id
}

output "ssh_command" {
  description = "Ready-to-use SSH command"
  value       = "ssh -i ${var.ssh_private_key_path} ${var.default_user}@${aws_instance.web.public_ip}"
}

output "website_url" {
  description = "URL of the nginx page"
  value       = "http://${aws_instance.web.public_ip}"
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = [for s in aws_subnet.public : s.id]
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = [for s in aws_subnet.private : s.id]
}
