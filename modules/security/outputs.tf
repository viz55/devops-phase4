output "web_security_group_id" {
  description = "ID of the web security group"
  value       = aws_security_group.web.id
}

output "web_security_group_name" {
  description = "Generated name of the web security group"
  value       = aws_security_group.web.name
}
