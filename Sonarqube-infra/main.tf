provider "aws" {
  region      = var.aws_region
  access_key  = var.access_key
  secret_key  = var.secret_key
}
# creation of vpc 
resource "aws_vpc" "vpc"{
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "msit-prod-vpc-sonar"
  }
}
# creation of Subnet
resource "aws_subnet" "subnet" {

  cidr_block = var.subnet_cidr_block
  vpc_id     = aws_vpc.vpc.id
  availability_zone = var.availability_zone

  tags = {
    Name = "Msit-prod-subnet-sonar"
  }
}
# creation of internet gate way
resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "msit-gateway"
  }
}
# creation of the route table and route table associations
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = var.all_cidr
    gateway_id = aws_internet_gateway.gateway.id
  }
  tags = {
    Name = "msit-routetable-sonar"
  }
}
resource "aws_route_table_association" "my_association" {

  route_table_id = aws_route_table.route_table.id
  subnet_id = aws_subnet.subnet.id
}

# creation of the security group and allow the required ports
resource "aws_security_group" "sonar_sg" {
  name        = "sonar_sg"
  description = "Allow Sonar Traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description      = "Allow from Personal CIDR block"
    from_port        = 9000
    to_port          = 9000
    protocol         = "tcp"
    cidr_blocks      = [var.all_cidr]
  }

  ingress {
    description      = "Allow SSH from Personal CIDR block"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.all_cidr]
  }
  ingress {
    description      = "Allow HTTP from Personal CIDR block"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [var.all_cidr]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.all_cidr]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Sonar SG"
  }
}
 # creation of the Ec2 instances 
resource "aws_instance" "sonar" {
  ami             = var.ami-id
  instance_type   = "t2.medium"
  key_name        = var.key_name
  security_groups = [aws_security_group.sonar_sg.id]
  subnet_id       = aws_subnet.subnet.id
  availability_zone = var.availability_zone
  user_data       = file("sonar-install.sh") # (we are create a file for install and updated the file here)
  associate_public_ip_address = var.associate_public_ip_address
  tags = {
    Name = "msit-sonar"
  }
}
output "sonar_endpoint" {
  value = formatlist("http://%s:%s/", aws_instance.sonar.*.public_ip, "9000")
}
