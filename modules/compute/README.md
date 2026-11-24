# compute module

Creates a key pair and one EC2 instance per entry of the `instances` map (`for_each`). Each instance has IMDSv2 enforced, an encrypted gp3 root volume, a public IP, and a user-data script (rendered with `templatefile()`) that installs Docker from the official repository and runs nginx on port 80.

With `protect_instances = true`, the instances are created by a second, identical block that has `prevent_destroy = true`.

This module has no provider block.

## Usage

```hcl
module "compute" {
  source             = "../../modules/compute"
  name_prefix        = "devops-phase4-dev"
  ami_id             = data.aws_ami.ubuntu.id
  subnet_ids         = module.vpc.public_subnet_ids
  security_group_ids = [module.security.web_security_group_id]
  ssh_public_key     = var.ssh_public_key
  instances = {
    web = { instance_type = "t3.micro", subnet_key = "public-1" }
  }
}
```

## Inputs

| Name | Type | Default | Description |
|---|---|---|---|
| name_prefix | string | none | Prefix for names and tags |
| ami_id | string | none | AMI to launch (validated) |
| subnet_ids | map(string) | none | Public subnet IDs from the vpc module |
| security_group_ids | list(string) | none | Security groups for every instance |
| ssh_public_key | string | none | Public SSH key (validated) |
| instances | map(object) | none | Name to instance_type and subnet_key (validated) |
| protect_instances | bool | false | Use the prevent_destroy instance block |
| default_user | string | ubuntu | Login user of the image |
| nginx_tag | string | 1.27-alpine | Pinned nginx image tag |
| root_volume_gb | number | 12 | Root volume size |
| detailed_monitoring | bool | true | Detailed CloudWatch monitoring |
| associate_public_ip | bool | true | Give each instance a public IPv4 address |
| user_data_replace_on_change | bool | true | Replace the instance when user-data changes |
| common_tags | map(string) | {} | Tags for the root volume |
| extra_tags | map(string) | {} | Extra instance tags |

## Outputs

| Name | Description |
|---|---|
| instances | Map of id, public_ip, private_ip and subnet_id per instance |
| instance_ids | List of instance IDs |
| public_ips | Map of public IPs per instance |
| key_name | Name of the key pair |
