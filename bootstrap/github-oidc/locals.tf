locals {
  github_oidc_url = "https://token.actions.githubusercontent.com"

  github_oidc_host = "token.actions.githubusercontent.com"

  github_immutable_subject = format(
    "repo:%s@%s/%s@%s:environment:%s",
    var.github_owner,
    var.github_owner_id,
    var.github_repository,
    var.github_repository_id,
    var.github_environment
  )

  deployment_role_name = "GitHubActions-Terraform-Windows-Production"

  common_tags = {
    Purpose       = "GitHub Actions OIDC authentication"
    Criticality   = "High"
    DataClass     = "Internal"
    CostCenter    = "Automation"
    ProvisionedBy = "Terraform Bootstrap"
  }
}
