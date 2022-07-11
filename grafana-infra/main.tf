provider "aws" {
  region      = var.aws_region
  access_key  = var.access_key
  secret_key  = var.secret_key
}
# creation of the vpc
resource "aws_vpc" "vpc"{
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "msit-prod-vpc-grafana"
  }
}
# creation of the subnet 
resource "aws_subnet" "subnet" {

  cidr_block = var.subnet_cidr_block
  vpc_id     = aws_vpc.vpc.id
  availability_zone = var.availability_zone

  tags = {
    Name = "Msit-prod-subnet-grafana"
  }
}
# crewation of the internet gateway
resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "msit-gateway"
  }
}
# creation of the routetable and routetable association
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = var.all_cidr
    gateway_id = aws_internet_gateway.gateway.id
  }
  tags = {
    Name = "msit-routetable-grafana"
  }
}
resource "aws_route_table_association" "my_association" {

  route_table_id = aws_route_table.route_table.id
  subnet_id = aws_subnet.subnet.id
}

# creation of the security group and allow the ports
resource "aws_security_group" "grafana_sg" {
  name        = "grafana_sg"
  description = "Allow Sonar Traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description      = "Allow from Personal CIDR block"
    from_port        = 3000
    to_port          = 3000
    protocol         = "tcp"
    cidr_blocks      = [var.all_cidr]
  }

  ingress {
    description      = "Allow  from Personal CIDR block"
    from_port        = 8081
    to_port          = 8081
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
  ingress {
    description      = "Allow SSh from Personal CIDR block"
    from_port        = 22
    to_port          = 22
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
    Name = "Grafana SG"
  }
}
# creation of the Ec2 instance
resource "aws_instance" "grafana" {
  ami             = var.ami-id
  instance_type   = "t2.micro"
  key_name        = var.key_name
  security_groups = [aws_security_group.grafana_sg.id]
  subnet_id       = aws_subnet.subnet.id
  availability_zone = var.availability_zone
  user_data       = file("grafana-install.sh") #(we are create a file for install and updated the file here)
  associate_public_ip_address = var.associate_public_ip_address
  tags = {
    Name = "msit-grafana"
  }
}
output "grafana_endpoint" {
  value = formatlist("http://%s:%s/", aws_instance.prom.*.public_ip, "3000")
}
