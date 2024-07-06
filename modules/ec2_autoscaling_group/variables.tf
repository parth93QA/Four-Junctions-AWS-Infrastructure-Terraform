variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "launch_template_name" {
  type = string
  default = "ionginx-launch-template"
}

variable "instance_name" {
  type = string
  default = "ionginx-ec2-instance"
}

variable "vpc_subnet_ids" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}