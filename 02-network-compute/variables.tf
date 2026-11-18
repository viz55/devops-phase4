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

variable "vpc_cidr" {
  description = "CIDR block of the VPC"
  type        = string
  default     = "10.0.0.0/16"

  validation {
    condition     = can(cidrnetmask(var.vpc_cidr))
    error_message = "vpc_cidr must be a valid IPv4 CIDR block."
  }
}

variable "web_ports" {
  description = "TCP ports opened to the internet on the web security group"
  type        = list(number)
  default     = [80, 443]
}

variable "ssh_allowed_cidr" {
  description = "Your public IP in CIDR form, for example 203.0.113.10/32. Never 0.0.0.0/0."
  type        = string

  validation {
    condition     = can(cidrnetmask(var.ssh_allowed_cidr)) && var.ssh_allowed_cidr != "0.0.0.0/0"
    error_message = "Give a valid CIDR such as 203.0.113.10/32. 0.0.0.0/0 is not allowed."
  }
}

variable "ssh_public_key" {
  description = "Public SSH key (contents of the .pub file)"
  type        = string

  validation {
    condition     = can(regex("^ssh-(ed25519|rsa) ", var.ssh_public_key))
    error_message = "Provide the full public key line starting with ssh-ed25519 or ssh-rsa."
  }
}

variable "ssh_private_key_path" {
  description = "Path of the private key on your laptop, used only to print the SSH command"
  type        = string
  default     = "~/.ssh/devops-phase4"
}

variable "instance_type" {
  description = "EC2 instance type. Only free-tier sized types are allowed."
  type        = string
  default     = "t3.micro"

  validation {
    condition     = contains(["t2.micro", "t3.micro"], var.instance_type)
    error_message = "Use t2.micro or t3.micro."
  }
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
  description = "Pinned nginx image tag for the container"
  type        = string
  default     = "1.27-alpine"
}
