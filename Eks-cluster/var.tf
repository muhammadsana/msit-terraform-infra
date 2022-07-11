 variable "aws_region" {
  description = "AWS region to create resources"
  default     = "us-east-2"
}
variable "access_key" {
    description = "Iam access key"
    default =  "Give a Acces key here from iam user credentials"                          #"AKIAVRHGMGJV5AE4YVNH"
}
variable "secret_key" {
    description = "Iam secret key"
    default =  "Give a Acces key here from iam user credentials"                      #"WiiTclD5MaA6PkvNxD9QLbm5D+8fJRPReqZqZSeH"
}
 variable "subnet_id_1" {
  type = string
  default = "subnet-your_first_subnet_id"
 }
 
 variable "subnet_id_2" {
  type = string
  default = "subnet-your_second_subnet_id"
 }
