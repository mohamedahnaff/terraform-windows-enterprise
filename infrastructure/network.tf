resource "aws_vpc" "windows" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${local.name_prefix}-vpc"
  }
}

resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs)

  vpc_id                  = aws_vpc.windows.id
  cidr_block              = var.private_subnet_cidrs[count.index]
  availability_zone       = local.selected_availability_zones[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = format(
      "%s-private-%02d",
      local.name_prefix,
      count.index + 1
    )

    Tier = "Private"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.windows.id

  tags = {
    Name = "${local.name_prefix}-private-rt"
  }
}

resource "aws_route_table_association" "private" {
  count = length(aws_subnet.private)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
