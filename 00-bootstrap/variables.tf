variable "region" {
  description = "AWS region. The account policy only allows ap-southeast-2."
  type        = string
  default     = "ap-southeast-2"
}

variable "project" {
  description = "Project name used as the prefix of the bucket and table"
  type        = string
  default     = "devops-phase4"
}

variable "owner" {
  description = "Person responsible for these resources"
  type        = string
  default     = "vishnu"
}
