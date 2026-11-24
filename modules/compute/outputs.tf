locals {
  all_instances = merge(aws_instance.web, aws_instance.protected)
}

output "instances" {
  description = "Details of every instance, keyed by instance name"
  value = {
    for k, i in local.all_instances : k => {
      id         = i.id
      public_ip  = i.public_ip
      private_ip = i.private_ip
      subnet_id  = i.subnet_id
    }
  }
}

output "instance_ids" {
  description = "IDs of all instances"
  value       = [for i in local.all_instances : i.id]
}

output "public_ips" {
  description = "Public IP of each instance, keyed by instance name"
  value       = { for k, i in local.all_instances : k => i.public_ip }
}

output "key_name" {
  description = "Name of the key pair"
  value       = aws_key_pair.lab.key_name
}
