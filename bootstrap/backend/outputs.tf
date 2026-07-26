output "aws_account_id" {
  description = "AWS account ID containing the backend."
  value       = data.aws_caller_identity.current.account_id
}

output "aws_region" {
  description = "AWS region containing the backend."
  value       = var.aws_region
}

output "state_bucket_name" {
  description = "Name of the Terraform remote state S3 bucket."
  value       = aws_s3_bucket.terraform_state.id
}

output "state_bucket_arn" {
  description = "ARN of the Terraform remote state S3 bucket."
  value       = aws_s3_bucket.terraform_state.arn
}

output "state_kms_key_arn" {
  description = "ARN of the KMS key used to encrypt Terraform state."
  value       = aws_kms_key.terraform_state.arn
}

output "state_kms_alias" {
  description = "Alias of the KMS key used to encrypt Terraform state."
  value       = aws_kms_alias.terraform_state.name
}

output "bootstrap_state_key" {
  description = "S3 object key for the backend bootstrap Terraform state."
  value       = "bootstrap/backend/terraform.tfstate"
}

output "infrastructure_state_key" {
  description = "S3 object key reserved for production Windows infrastructure."
  value       = "infrastructure/prod/windows/terraform.tfstate"
}
