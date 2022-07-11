provider "aws" {
  region      = var.aws_region
  access_key  = var.access_key
  secret_key  = var.secret_key
}
# creation of the Vpc 
resource "aws_vpc" "vpc"{
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "msit-prod-vpc"
  }
}
# creation of the Subnet
resource "aws_subnet" "subnet" {
  cidr_block = var.subnet_cidr_block
  vpc_id     = aws_vpc.vpc.id
   
  tags = {
    Name = "msit-prod-subnet"
  }
}
#resource "aws_eip" "eip" {
 # vpc = true
  #tags = {
   # Name = "Msit-eip"
 # }
#}

# creation of the Internet gateway
resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "msit-gateway"
  }
}
# creation of the route table and route associations
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = var.all_cidr
    gateway_id = aws_internet_gateway.gateway.id
  }
  tags = {
    Name = "msit-routetable"
  }
}
resource "aws_route_table_association" "route-association" {
  route_table_id = aws_route_table.route_table.id
  subnet_id = aws_subnet.subnet.id
}
# creation of the security group and allow the ports required
resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins_sg"
  description = "Allow Jenkins Traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description      = "Allow from Personal CIDR block"
    from_port        = 8080
    to_port          = 8080
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

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.all_cidr]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Jenkins SG"
  }
}
# creation of the ec2 instance
 resource "aws_instance" "web" {
  ami             = var.ami-id
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [aws_security_group.jenkins_sg.id]
  subnet_id       = aws_subnet.subnet.id
  user_data       = file("jenkins-install.sh") #(we are create a file for install and updated the file here)
  associate_public_ip_address = var.associate_public_ip_address

  tags = {
    Name = "msit-Jenkins"
  }
 }
 output "jenkins_endpoint" {
  value = formatlist("http://%s:%s/", aws_instance.web.*.public_ip, "8080")
}
