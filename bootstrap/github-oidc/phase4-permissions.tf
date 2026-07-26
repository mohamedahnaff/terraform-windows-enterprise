data "aws_iam_policy_document" "phase4_support" {
  statement {
    sid    = "ReadWindowsAMIParameter"
    effect = "Allow"

    actions = [
      "ssm:GetParameter",
      "ssm:GetParameters"
    ]

    resources = [
      "arn:${data.aws_partition.current.partition}:ssm:${var.aws_region}::parameter/aws/service/ami-windows-latest/*"
    ]
  }

  statement {
    sid    = "AdditionalEC2ReadPermissions"
    effect = "Allow"

    actions = [
      "ec2:DescribeAccountAttributes",
      "ec2:DescribeDhcpOptions",
      "ec2:DescribeInstanceAttribute",
      "ec2:DescribeInstanceStatus",
      "ec2:DescribeIamInstanceProfileAssociations",
      "ec2:DescribeVpcEndpointServices"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "phase4_support" {
  name        = "GitHubActions-Terraform-Windows-Phase4-Support"
  description = "Additional permissions required for Windows infrastructure deployment"
  policy      = data.aws_iam_policy_document.phase4_support.json

  tags = merge(
    local.common_tags,
    {
      Name = "GitHubActions-Terraform-Windows-Phase4-Support"
    }
  )
}

resource "aws_iam_role_policy_attachment" "phase4_support" {
  role       = aws_iam_role.github_actions_terraform.name
  policy_arn = aws_iam_policy.phase4_support.arn
}
