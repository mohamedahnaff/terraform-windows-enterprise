variable "aws_region" {
  description = "AWS region in which the Terraform backend resources will be created."
  type        = string

  validation {
    condition     = length(trimspace(var.aws_region)) > 0
    error_message = "The AWS region must not be empty."
  }
}

variable "project_name" {
  description = "Project name used for resource naming and tagging."
  type        = string
  default     = "terraform-windows-enterprise"
}

variable "environment" {
  description = "Environment associated with the backend."
  type        = string
  default     = "shared"
}

variable "repository_name" {
  description = "GitHub repository associated with the Terraform project."
  type        = string
  default     = "terraform-windows-enterprise"
}

variable "owner" {
  description = "Owner responsible for the infrastructure."
  type        = string
  default     = "Abdul-Ahnaf"
}

variable "state_retention_days" {
  description = "Number of days to retain noncurrent Terraform state versions."
  type        = number
  default     = 365

  validation {
    condition     = var.state_retention_days >= 90
    error_message = "State retention must be at least 90 days."
  }
}
