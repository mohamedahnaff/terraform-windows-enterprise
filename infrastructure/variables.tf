variable "aws_region" {
  description = "AWS region where the Windows infrastructure will be deployed."
  type        = string
  default     = "ap-south-1"

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
  description = "Deployment environment."
  type        = string
  default     = "production"

  validation {
    condition = contains(
      ["development", "testing", "staging", "production"],
      var.environment
    )
    error_message = "Environment must be development, testing, staging, or production."
  }
}

variable "owner" {
  description = "Owner responsible for the infrastructure."
  type        = string
  default     = "Abdul-Ahnaf"
}

variable "cost_center" {
  description = "Enterprise cost center."
  type        = string
  default     = "Automation"
}

variable "service_now_request" {
  description = "ServiceNow request or RITM number."
  type        = string
  default     = "MANUAL-PHASE-4"
}

variable "vpc_cidr" {
  description = "CIDR range for the enterprise Windows VPC."
  type        = string
  default     = "10.40.0.0/16"

  validation {
    condition     = can(cidrnetmask(var.vpc_cidr))
    error_message = "VPC CIDR must be a valid IPv4 CIDR range."
  }
}

variable "private_subnet_cidrs" {
  description = "CIDR ranges for the two private subnets."
  type        = list(string)

  default = [
    "10.40.10.0/24",
    "10.40.20.0/24"
  ]

  validation {
    condition = (
      length(var.private_subnet_cidrs) == 2 &&
      alltrue([
        for cidr in var.private_subnet_cidrs :
        can(cidrnetmask(cidr))
      ])
    )
    error_message = "Exactly two valid private subnet CIDRs must be supplied."
  }
}

variable "instance_count" {
  description = "Number of Windows instances."
  type        = number
  default     = 2

  validation {
    condition     = var.instance_count == 2
    error_message = "This project must provision exactly two Windows instances."
  }
}

variable "instance_type" {
  description = "Approved EC2 instance type."
  type        = string
  default     = "t3.medium"

  validation {
    condition = contains(
      ["t3.medium", "t3.large", "m6i.large"],
      var.instance_type
    )
    error_message = "Instance type must be t3.medium, t3.large, or m6i.large."
  }
}

variable "root_volume_size" {
  description = "Windows root volume size in GiB."
  type        = number
  default     = 50

  validation {
    condition = (
      var.root_volume_size >= 30 &&
      var.root_volume_size <= 500
    )
    error_message = "Root volume size must be between 30 and 500 GiB."
  }
}

variable "windows_ami_parameter_name" {
  description = "AWS public SSM parameter containing the Windows Server AMI ID."
  type        = string
  default     = "/aws/service/ami-windows-latest/Windows_Server-2022-English-Full-Base"
}

variable "secret_recovery_window_days" {
  description = "Secrets Manager recovery period."
  type        = number
  default     = 30

  validation {
    condition = (
      var.secret_recovery_window_days >= 7 &&
      var.secret_recovery_window_days <= 30
    )
    error_message = "Secret recovery window must be between 7 and 30 days."
  }
}
