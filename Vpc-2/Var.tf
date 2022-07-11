variable "aws_region" {
  description = "AWS region to create resources"
  default     = "us-east-2"
}
variable "access_key" {
    description = "Iam access key"
    default = "Give a Acces key here from iam user credentials"
}
variable "secret_key" {
    description = "Iam secret key"
    default = "Give a Acces key here from iam user credentials"
}
variable "cidr_block" {
  default     = "10.0.0.0/16"
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidr_blocks" {
  default     = ["10.0.0.0/24", "10.0.2.0/24"]
  type        = list
  description = "List of public subnet CIDR blocks"
}

variable "private_subnet_cidr_blocks" {
  default     = ["10.0.1.0/24", "10.0.3.0/24"]
  type        = list
  description = "List of private subnet CIDR blocks"
}

variable "availability_zones" {
  default     = ["us-east-2a", "us-east-2b"]
  type        = list
  description = "List of availability zones"
}
