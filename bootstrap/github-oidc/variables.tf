variable "aws_region" {
  description = "AWS region used by the project."
  type        = string

  validation {
    condition     = length(trimspace(var.aws_region)) > 0
    error_message = "AWS region must not be empty."
  }
}

variable "project_name" {
  description = "Project name used for naming and tagging."
  type        = string
  default     = "terraform-windows-enterprise"
}

variable "environment" {
  description = "AWS resource environment associated with this bootstrap configuration."
  type        = string
  default     = "shared"
}

variable "owner" {
  description = "Owner responsible for the project."
  type        = string
  default     = "Abdul-Ahnaf"
}

variable "github_owner" {
  description = "GitHub personal account or organization name."
  type        = string
}

variable "github_owner_id" {
  description = "Immutable numeric GitHub owner ID."
  type        = string

  validation {
    condition     = can(regex("^[0-9]+$", var.github_owner_id))
    error_message = "GitHub owner ID must contain only numbers."
  }
}

variable "github_repository" {
  description = "GitHub repository name."
  type        = string
}

variable "github_repository_id" {
  description = "Immutable numeric GitHub repository ID."
  type        = string

  validation {
    condition     = can(regex("^[0-9]+$", var.github_repository_id))
    error_message = "GitHub repository ID must contain only numbers."
  }
}

variable "github_environment" {
  description = "GitHub environment authorized to assume the AWS deployment role."
  type        = string
  default     = "production"
}

variable "state_bucket_name" {
  description = "S3 bucket containing Terraform remote state."
  type        = string
}

variable "state_kms_key_arn" {
  description = "ARN of the KMS key encrypting Terraform state."
  type        = string
}
