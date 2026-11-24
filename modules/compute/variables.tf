variable "name_prefix" {
  description = "Prefix for the Name tag of every resource"
  type        = string
}

variable "ami_id" {
  description = "AMI ID to launch"
  type        = string

  validation {
    condition     = startswith(var.ami_id, "ami-")
    error_message = "ami_id must look like ami-0123456789abcdef0."
  }
}

variable "subnet_ids" {
  description = "Public subnet IDs keyed by subnet name, from the vpc module"
  type        = map(string)
}

variable "security_group_ids" {
  description = "Security groups attached to every instance"
  type        = list(string)
}

variable "ssh_public_key" {
  description = "Public SSH key (contents of the .pub file)"
  type        = string

  validation {
    condition     = can(regex("^ssh-(ed25519|rsa) ", var.ssh_public_key))
    error_message = "Provide the full public key line starting with ssh-ed25519 or ssh-rsa."
  }
}

variable "instances" {
  description = "Instances to create. The map key becomes the instance name, subnet_key picks a public subnet."
  type = map(object({
    instance_type = string
    subnet_key    = string
  }))

  validation {
    condition     = length(var.instances) >= 1
    error_message = "Define at least one instance."
  }

  validation {
    condition     = alltrue([for k, v in var.instances : contains(["t2.micro", "t3.micro", "t3.small"], v.instance_type)])
    error_message = "instance_type must be t2.micro, t3.micro or t3.small."
  }
}

variable "protect_instances" {
  description = "When true, instances are created with prevent_destroy. Lifecycle settings cannot be variables, so the module holds two identical instance blocks."
  type        = bool
  default     = false
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

variable "root_volume_gb" {
  description = "Size of the encrypted root volume in GB"
  type        = number
  default     = 12
}

variable "detailed_monitoring" {
  description = "Enable detailed CloudWatch monitoring (billed per instance)"
  type        = bool
  default     = true
}

variable "user_data_replace_on_change" {
  description = "Replace the instance when the user-data script changes"
  type        = bool
  default     = true
}

variable "common_tags" {
  description = "Tags copied onto the root volume (provider default tags do not reach it)"
  type        = map(string)
  default     = {}
}

variable "extra_tags" {
  description = "Extra tags for every instance"
  type        = map(string)
  default     = {}
}

variable "associate_public_ip" {
  description = "Give each instance a public IPv4 address. Keep true except when adopting an existing instance that has none."
  type        = bool
  default     = true
}
