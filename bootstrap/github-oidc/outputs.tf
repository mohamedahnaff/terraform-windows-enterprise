output "aws_account_id" {
  description = "AWS account containing the GitHub OIDC integration."
  value       = data.aws_caller_identity.current.account_id
}

output "github_oidc_provider_arn" {
  description = "ARN of the GitHub Actions OIDC provider."
  value       = aws_iam_openid_connect_provider.github.arn
}

output "github_actions_role_name" {
  description = "Name of the GitHub Actions Terraform deployment role."
  value       = aws_iam_role.github_actions_terraform.name
}

output "github_actions_role_arn" {
  description = "ARN of the GitHub Actions Terraform deployment role."
  value       = aws_iam_role.github_actions_terraform.arn
}

output "github_immutable_subject" {
  description = "Exact GitHub OIDC subject authorized by the role trust policy."
  value       = local.github_immutable_subject
}

output "deployment_policy_arn" {
  description = "ARN of the GitHub Actions Terraform deployment policy."
  value       = aws_iam_policy.terraform_deployment.arn
}
