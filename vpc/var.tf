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
  description = "CIDR block of the vpc"
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr_block" {
  
  description = "CIDR block for Public Subnet"
  default     = "10.0.0.0/24"
}

variable "private_subnet_cidr_block" {

  description = "CIDR block for Private Subnet"
  default     = "10.0.3.0/24"
}

variable "all_cidr" {
  description = "CIDR Block to allow Jenkins Access"
  default = "0.0.0.0/0"
}

variable "availability_zones" {
   
   default     =   "ap-south-1b"
  description = "AZ in which all the resources will be deployed"
}
