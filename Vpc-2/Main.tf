provider "aws" {
      region         = var.aws_region
      access_key     = var.access_key
      secret_key     = var.secret_key
}


## VPC resources: This will create 1 VPC with 4 Subnets, 1 Internet Gateway, 4 Route Tables.
# Creation of vpc
resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "Msit-prod-vpc"
  }
}
# Internet Gateway for Public Subnet
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "Msit-prod-igw"
  }
}
# Route table for private subnet
resource "aws_route_table" "private" {
  count = length(var.private_subnet_cidr_blocks)

  vpc_id = aws_vpc.vpc.id
}

resource "aws_route" "private" {
  count = length(var.private_subnet_cidr_blocks)

  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat[count.index].id
}
 #Route table for public subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

 #Creation of private subnet
resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidr_blocks)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet_cidr_blocks[count.index]
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name = "Msit-prod-${element(var.availability_zones, count.index)}-privatesubnet"
  }
}
 # Creation of public subnet
resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidr_blocks)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_cidr_blocks[count.index]
  availability_zone       =  var.availability_zones[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "Msit-prod-${element(var.availability_zones, count.index)}-publicsubnet"
  }
}

# Route_table association for private
resource "aws_route_table_association" "private" {
  count          = length(var.private_subnet_cidr_blocks)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id

}

# Route_table association for public
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_cidr_blocks)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id

}


# NAT resources: This will create 2 NAT gateways in 2 Public Subnets for 2 different Private Subnets.

resource "aws_eip" "eip" {
  count = length(var.public_subnet_cidr_blocks)

  vpc = true
  tags = {
    Name = "Msit-eip"
  }
}

resource "aws_nat_gateway" "nat" {
  depends_on = [aws_internet_gateway.igw]

  count = length(var.public_subnet_cidr_blocks)

  allocation_id = aws_eip.eip[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  tags = {
    Name = "Msit-nat"
  }
}
