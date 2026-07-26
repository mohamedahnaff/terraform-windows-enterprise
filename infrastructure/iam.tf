data "aws_iam_policy_document" "windows_ec2_trust" {
  statement {
    sid     = "AllowEC2AssumeRole"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"

      identifiers = [
        "ec2.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_role" "windows_ssm" {
  name = "${var.project_name}-${var.environment}-windows-ssm-role"

  description = "IAM role allowing Windows instances to register with Systems Manager"

  assume_role_policy = data.aws_iam_policy_document.windows_ec2_trust.json

  tags = {
    Name = "${local.name_prefix}-windows-ssm-role"
  }
}

resource "aws_iam_role_policy_attachment" "windows_ssm" {
  role = aws_iam_role.windows_ssm.name

  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "windows_ssm" {
  name = "${var.project_name}-${var.environment}-windows-ssm-profile"
  role = aws_iam_role.windows_ssm.name

  tags = {
    Name = "${local.name_prefix}-windows-ssm-profile"
  }
}
