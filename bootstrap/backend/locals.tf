locals {
  state_bucket_name = lower(
    "tfstate-${data.aws_caller_identity.current.account_id}-${var.aws_region}"
  )

  common_tags = {
    Purpose       = "Terraform remote state storage"
    DataClass     = "Confidential"
    Criticality   = "High"
    CostCenter    = "Automation"
    ProvisionedBy = "Terraform Bootstrap"
  }
}
