variable "region" {
  description = "AWS region for the primary provider"
  type        = string
  default     = "ap-southeast-2"

  validation {
    condition     = can(regex("^[a-z]{2}-[a-z]+-[0-9]$", var.region))
    error_message = "Region must look like ap-south-1."
  }
}

variable "secondary_region" {
  description = "Second region, used through the aliased provider"
  type        = string
  default     = "ap-southeast-2"
}

variable "project" {
  description = "Project name used in names and tags"
  type        = string
  default     = "devops-phase4"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging or prod."
  }
}

variable "owner" {
  description = "Person responsible for these resources"
  type        = string
  default     = "vishnu"
}

variable "env_cidrs" {
  description = "VPC CIDR block for each environment"
  type        = map(string)
  default = {
    dev     = "10.10.0.0/16"
    staging = "10.20.0.0/16"
    prod    = "10.30.0.0/16"
  }
}

variable "create_igw" {
  description = "Whether to create an internet gateway"
  type        = bool
  default     = true
}

variable "extra_sg_count" {
  description = "Number of extra security groups to create with count"
  type        = number
  default     = 1

  validation {
    condition     = var.extra_sg_count >= 0 && var.extra_sg_count <= 3
    error_message = "extra_sg_count must be between 0 and 3."
  }
}

variable "ingress_ports" {
  description = "TCP ports opened on the web security group"
  type        = list(number)
  default     = [80, 443]

  validation {
    condition     = alltrue([for p in var.ingress_ports : p >= 1 && p <= 65535])
    error_message = "Every port must be between 1 and 65535."
  }
}

variable "subnets" {
  description = "Subnets to create, keyed by name"
  type = map(object({
    az_index   = number
    cidr_index = number
    public     = bool
  }))
  default = {
    public-a  = { az_index = 0, cidr_index = 1, public = true }
    private-a = { az_index = 0, cidr_index = 11, public = false }
    private-b = { az_index = 1, cidr_index = 12, public = false }
  }
}

variable "settings" {
  description = "Planned compute settings"
  type = object({
    instance_type = string
    volume_gb     = number
  })
  default = {
    instance_type = "t3.micro"
    volume_gb     = 20
  }
}

variable "extra_tags" {
  description = "Additional tags merged into the VPC tags"
  type        = map(string)
  default     = {}
}

variable "db_password" {
  description = "Example secret, supplied only through TF_VAR_db_password"
  type        = string
  sensitive   = true

  validation {
    condition     = length(var.db_password) >= 12
    error_message = "The password must be at least 12 characters."
  }
}

variable "precedence_demo" {
  description = "Harmless value used to show variable precedence"
  type        = string
  default     = "from-default"
}

variable "demo_names" {
  description = "Names used in the count versus for_each demo"
  type        = list(string)
  default     = ["alpha", "bravo", "charlie"]
}
