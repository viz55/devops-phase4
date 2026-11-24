# security module

Creates the web security group: HTTP and HTTPS from anywhere, SSH from one address only, and outbound traffic limited to the listed ports. Security groups are stateful, so return traffic needs no extra rule.

This module has no provider block.

## Usage

```hcl
module "security" {
  source           = "../../modules/security"
  name_prefix      = "devops-phase4-dev"
  vpc_id           = module.vpc.vpc_id
  ssh_allowed_cidr = "203.0.113.10/32"
}
```

## Inputs

| Name | Type | Default | Description |
|---|---|---|---|
| name_prefix | string | none | Prefix for names and tags |
| vpc_id | string | none | VPC of the security group (validated) |
| ssh_allowed_cidr | string | none | Admin IP in CIDR form, never 0.0.0.0/0 (validated) |
| web_ports | list(number) | [80, 443] | TCP ports open to the internet |
| egress_ports | list(number) | [80, 443] | TCP ports allowed outbound |
| ssh_port | number | 22 | SSH port |
| web_ingress_cidr | string | 0.0.0.0/0 | Source for web ports |
| egress_cidr | string | 0.0.0.0/0 | Destination for outbound rules |
| description | string | see variables.tf | Security group description |
| ssh_description | string | Allow SSH from the admin address only | SSH rule description |

## Outputs

| Name | Description |
|---|---|
| web_security_group_id | ID of the web security group |
| web_security_group_name | Generated name of the group |
