variable "name_prefix" {
  description = "Prefix for the Name tag of every resource"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block of the VPC"
  type        = string

  validation {
    condition     = can(cidrnetmask(var.vpc_cidr))
    error_message = "vpc_cidr must be a valid IPv4 CIDR block."
  }
}

variable "az_names" {
  description = "Availability zone names. One public and one private subnet is created per zone."
  type        = list(string)

  validation {
    condition     = length(var.az_names) >= 1 && length(var.az_names) <= 3
    error_message = "Provide between 1 and 3 availability zone names."
  }
}

variable "subnet_newbits" {
  description = "Extra prefix bits for cidrsubnet(). 8 turns a /16 into /24 subnets."
  type        = number
  default     = 8
}

variable "private_netnum_offset" {
  description = "Number added to the zone index to pick private subnet ranges, so they never overlap the public ones"
  type        = number
  default     = 10
}

variable "internet_cidr" {
  description = "Destination CIDR of the public default route"
  type        = string
  default     = "0.0.0.0/0"
}
