output "aws_account_id" {
  description = "AWS account containing the Windows infrastructure."
  value       = data.aws_caller_identity.current.account_id
}

output "aws_region" {
  description = "AWS region containing the Windows infrastructure."
  value       = var.aws_region
}

output "vpc_id" {
  description = "ID of the enterprise Windows VPC."
  value       = aws_vpc.windows.id
}

output "private_subnet_ids" {
  description = "IDs of the private subnets."
  value       = aws_subnet.private[*].id
}

output "windows_instance_ids" {
  description = "Windows EC2 instance IDs."

  value = {
    for key, instance in aws_instance.windows :
    key => instance.id
  }
}

output "windows_private_ips" {
  description = "Private IP addresses of the Windows instances."

  value = {
    for key, instance in aws_instance.windows :
    key => instance.private_ip
  }
}

output "windows_availability_zones" {
  description = "Availability Zones containing the Windows instances."

  value = {
    for key, instance in aws_instance.windows :
    key => instance.availability_zone
  }
}

output "windows_instance_names" {
  description = "Name tags assigned to the Windows instances."

  value = {
    for key, values in local.windows_instances :
    key => values.display_name
  }
}

output "windows_ami_id" {
  description = "Windows Server AMI ID resolved from the AWS public Parameter Store parameter."
  value       = data.aws_ssm_parameter.windows_ami.value
  sensitive   = true
}

output "windows_ami_parameter" {
  description = "SSM public parameter used to resolve the Windows AMI."
  value       = var.windows_ami_parameter_name
}

output "ssm_instance_profile_name" {
  description = "IAM instance profile assigned to the Windows instances."
  value       = aws_iam_instance_profile.windows_ssm.name
}

output "windows_administrator_secret_arn" {
  description = "ARN of the reserved Windows administrator credential secret."
  value       = aws_secretsmanager_secret.windows_administrator.arn
}

output "ssm_endpoint_ids" {
  description = "Systems Manager VPC endpoint IDs."

  value = {
    for service, endpoint in aws_vpc_endpoint.ssm :
    service => endpoint.id
  }
}
