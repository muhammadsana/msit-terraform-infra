variable "aws_region" {
  
  description = "AWS region to create resources"
  default     = "ex: ap-south-1  ( give the region here)"
}
variable "access_key" {
    description = "Iam access key"
    default = "Give a Acces key here from iam user credentials"
}
variable "secret_key" {
    description = "Iam secret key"
    default = "Give a secret key here from iam user credentials"
}

variable "vpc_cidr_block" {
  description = "VPC for Sonar"
  default = "10.10.0.0/16"

}
variable "subnet_cidr_block" {
    description = "Subnet for Sonar"
    default = "10.10.1.0/24"
}
variable "availability_zone" {
    description = "Create a availability zone"
    default = "ap-south-1a"
    
}

variable "all_cidr" {
  description = "CIDR Block to allow Jenkins Access"
  default = "0.0.0.0/0"
}
variable "ami-id" {
  description = "Ami id for Ec2"
  default = "ami-0756a1c858554433e (specify the ami id here)"
}

variable "key_name" {
  description = "Name of keypair to ssh"
  default = " (create a key pair first and give the name of the key pair)"
}

variable "associate_public_ip_address" {
    description = "To give acces to public Ip address"
    default = "true"
}
