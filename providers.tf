
terraform {
  required_version = "~>1.8.0"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~>5.40.0"
    } 
  }
  backend "s3" {
    bucket = "terraform-vpc-ec2-asg"
    key = "terraform.tfstate"
    dynamodb_table = "vpc-wc2-asg"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}
