variable "name_prefix" {
  description = "Prefix for the Name tag of every resource"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC that the security group belongs to"
  type        = string

  validation {
    condition     = startswith(var.vpc_id, "vpc-")
    error_message = "vpc_id must look like vpc-0123456789abcdef0."
  }
}

variable "ssh_allowed_cidr" {
  description = "Your public IP in CIDR form, for example 203.0.113.10/32. Never 0.0.0.0/0."
  type        = string

  validation {
    condition     = can(cidrnetmask(var.ssh_allowed_cidr)) && var.ssh_allowed_cidr != "0.0.0.0/0"
    error_message = "Give a valid CIDR such as 203.0.113.10/32. 0.0.0.0/0 is not allowed."
  }
}

variable "web_ports" {
  description = "TCP ports opened to the internet"
  type        = list(number)
  default     = [80, 443]

  validation {
    condition     = alltrue([for p in var.web_ports : p >= 1 && p <= 65535])
    error_message = "Every port must be between 1 and 65535."
  }
}

variable "egress_ports" {
  description = "TCP ports the instance may reach outbound (package and image downloads)"
  type        = list(number)
  default     = [80, 443]
}

variable "ssh_port" {
  description = "TCP port used for SSH"
  type        = number
  default     = 22
}

variable "web_ingress_cidr" {
  description = "Source CIDR for the web ports"
  type        = string
  default     = "0.0.0.0/0"
}

variable "egress_cidr" {
  description = "Destination CIDR for outbound traffic"
  type        = string
  default     = "0.0.0.0/0"
}

variable "description" {
  description = "Description of the security group"
  type        = string
  default     = "Web server: HTTP and HTTPS from anywhere, SSH from one address"
}

variable "ssh_description" {
  description = "Description of the SSH rule"
  type        = string
  default     = "Allow SSH from the admin address only"
}
