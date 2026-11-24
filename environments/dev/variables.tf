variable "region" {
  description = "AWS region. The account policy only allows ap-southeast-2."
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

variable "vpc_cidr" {
  description = "CIDR block of the VPC"
  type        = string
}

variable "az_count" {
  description = "Number of availability zones to use"
  type        = number
  default     = 1

  validation {
    condition     = var.az_count >= 1 && var.az_count <= 2
    error_message = "az_count must be 1 or 2."
  }
}

variable "availability_zones" {
  description = "Availability zone names to choose from (pinned)"
  type        = list(string)
  default     = ["ap-southeast-2a", "ap-southeast-2b"]
}

variable "instances" {
  description = "Instances to create, keyed by name"
  type = map(object({
    instance_type = string
    subnet_key    = string
  }))
}

variable "protect_instances" {
  description = "Create instances with prevent_destroy"
  type        = bool
  default     = false
}

variable "web_ports" {
  description = "TCP ports opened to the internet"
  type        = list(number)
  default     = [80, 443]
}

variable "ssh_allowed_cidr" {
  description = "Your public IP in CIDR form. Set in local.auto.tfvars, which is not committed."
  type        = string
}

variable "ssh_public_key" {
  description = "Public SSH key. Set in local.auto.tfvars, which is not committed."
  type        = string
}

variable "ssh_private_key_path" {
  description = "Path of the private key on your laptop, used only to print SSH commands"
  type        = string
  default     = "~/.ssh/devops-phase4"
}

variable "ami_name_pattern" {
  description = "Name pattern of the Ubuntu image to look up (Canonical only)"
  type        = string
  default     = "ubuntu/images/hvm-ssd*/ubuntu-*-26.04-amd64-server-*"
}

variable "default_user" {
  description = "Default login user of the Ubuntu image"
  type        = string
  default     = "ubuntu"
}

variable "nginx_tag" {
  description = "Pinned nginx image tag"
  type        = string
  default     = "1.27-alpine"
}
