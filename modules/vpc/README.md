# vpc module

Creates a VPC with DNS support and hostnames, one public and one private subnet per availability zone, an internet gateway, a public route table (default route to the gateway), a private route table (no internet route, no NAT), and a locked-down default security group.

Provider configuration is inherited from the caller. This module has no provider block.

## Usage

```hcl
module "vpc" {
  source      = "../../modules/vpc"
  name_prefix = "devops-phase4-dev"
  vpc_cidr    = "10.10.0.0/16"
  az_names    = ["ap-southeast-2a", "ap-southeast-2b"]
}
```

## Inputs

| Name | Type | Default | Description |
|---|---|---|---|
| name_prefix | string | none | Prefix for the Name tag of every resource |
| vpc_cidr | string | none | CIDR block of the VPC (validated) |
| az_names | list(string) | none | Availability zone names, 1 to 3 (validated) |
| subnet_newbits | number | 8 | Extra prefix bits for cidrsubnet() |
| private_netnum_offset | number | 10 | Offset for private subnet ranges |
| internet_cidr | string | 0.0.0.0/0 | Destination of the public default route |

## Outputs

| Name | Description |
|---|---|
| vpc_id | ID of the VPC |
| vpc_cidr | CIDR block of the VPC |
| public_subnet_ids | Map of public subnet IDs (public-1, public-2) |
| private_subnet_ids | Map of private subnet IDs (private-1, private-2) |
| internet_gateway_id | ID of the internet gateway |
