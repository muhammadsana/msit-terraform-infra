provider "aws"{
  region      = var.aws_region
  access_key  = var.access_key
  secret_key  = var.secret_key
}

# VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "Msit-prod-vpc"    
  }
}

#Public Subnet
resource "aws_subnet" "public-subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_cidr_block
  availability_zone       = var.availability_zones
  map_public_ip_on_launch = true

  tags = {
    Name        = "Msit-prod-public-subnet"
  }
}

# Private Subnet
resource "aws_subnet" "private-subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnet_cidr_block
  availability_zone       = var.availability_zones
  map_public_ip_on_launch = false

  tags = {
    Name        = "Msit-prod-private-subnet"
  }
}

# Internet Gateway for Public Subnet
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name        = "Msit-prod-public-igw"
  }
}

# Routing table to route traffic for Private Subnet
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = var.all_cidr
    gateway_id = aws_internet_gateway.igw.id  
  }
  tags = {
    Name        = "Msit-prod-private-routetable"
  }
}

# Routing table to route traffic for Public Subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  route {
  cidr_block = var.all_cidr              
  gateway_id = aws_internet_gateway.igw.id  
  }
  tags = {
    Name        = "Msit-prod-public-routetable"
  }
}

# Route for Internet Gateway
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}


# Route table associations for  Public  Subnets
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public.id
}
# Route table association for private subnets
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.private.id
}
# Create of Elstic Ip attach to private
 resource "aws_eip" "nateIP" {
   vpc   = true
 }
# Creating the NAT Gateway using subnet_id and allocation_id for private 
 resource "aws_nat_gateway" "NATgw" {
   allocation_id = aws_eip.nateIP.id
   subnet_id = aws_subnet.private-subnet.id

 }
