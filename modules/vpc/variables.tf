variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "vpc_name" {
  type = string
  default = "ionginx-vpc"
}

variable "vpc_public_subnet_cidr"{
    type = list(string)
    default = [ "10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24" ]
}

variable "vpc_private_subnet_cidr" {
  type = list(string)
  default = [ "10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24" ]
}

variable "azs" {
  type = list(string)
  default = [ "us-east-1a", "us-east-1b", "us-east-1c"  ]
}