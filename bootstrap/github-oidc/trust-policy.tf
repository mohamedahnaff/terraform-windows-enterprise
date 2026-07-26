data "aws_iam_policy_document" "github_actions_trust" {
  statement {
    sid     = "AllowGitHubActionsOIDC"
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type = "Federated"

      identifiers = [
        aws_iam_openid_connect_provider.github.arn
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "${local.github_oidc_host}:aud"

      values = [
        "sts.amazonaws.com"
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "${local.github_oidc_host}:sub"

      values = [
        local.github_immutable_subject
      ]
    }
  }
}

resource "aws_iam_role" "github_actions_terraform" {
  name                 = local.deployment_role_name
  description          = "Terraform deployment role assumed by GitHub Actions through OIDC"
  assume_role_policy   = data.aws_iam_policy_document.github_actions_trust.json
  max_session_duration = 3600

  tags = merge(
    local.common_tags,
    {
      Name = local.deployment_role_name
    }
  )
}
