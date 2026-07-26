resource "aws_instance" "windows" {
  for_each = local.windows_instances

  ami           = data.aws_ssm_parameter.windows_ami.value
  instance_type = var.instance_type

  subnet_id = aws_subnet.private[each.value.subnet_index].id

  vpc_security_group_ids = [
    aws_security_group.windows.id
  ]

  iam_instance_profile = aws_iam_instance_profile.windows_ssm.name

  associate_public_ip_address = false
  monitoring                  = true

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "disabled"
  }

  root_block_device {
    volume_type           = "gp3"
    volume_size           = var.root_volume_size
    encrypted             = true
    delete_on_termination = true

    tags = merge(
      local.common_tags,
      {
        Name          = "${each.value.display_name}-root"
        InstanceName  = each.value.display_name
        VolumePurpose = "WindowsRootVolume"
      }
    )
  }

  tags = {
    Name             = each.value.display_name
    WindowsHostLabel = each.value.name
    OperatingSystem  = "Windows Server 2022"
    ManagementMethod = "AWS Systems Manager"
    PublicAccess     = "Disabled"
  }

  depends_on = [
    aws_iam_role_policy_attachment.windows_ssm,
    aws_vpc_endpoint.ssm
  ]

  lifecycle {
    precondition {
      condition     = length(local.selected_availability_zones) >= 2
      error_message = "The AWS region must provide at least two Availability Zones."
    }
  }
}
