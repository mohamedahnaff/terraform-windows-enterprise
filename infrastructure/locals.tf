locals {
  name_prefix = "${var.project_name}-${var.environment}"

  selected_availability_zones = slice(
    data.aws_availability_zones.available.names,
    0,
    2
  )

  windows_instances = {
    for index in range(var.instance_count) :
    format("%02d", index + 1) => {
      name              = format("WIN-%02d", index + 1)
      display_name      = format("%s-windows-%02d", local.name_prefix, index + 1)
      subnet_index      = index
      availability_zone = local.selected_availability_zones[index]
    }
  }

  common_tags = {
    Project           = var.project_name
    Environment       = var.environment
    ManagedBy         = "Terraform"
    Owner             = var.owner
    CostCenter        = var.cost_center
    ServiceNowRequest = var.service_now_request
    Repository        = "terraform-windows-enterprise"
    DataClass         = "Confidential"
    Criticality       = "High"
  }
}
