output "vpc_id" {
  value = aws_vpc.ionginx-vpc.id
}

output "vpc_public_subnets" {
  value = aws_subnet.ionginx-public-subnet
}

output "vpc_private_subnets" {
  value = aws_subnet.ionginx-private-subnet[*].id
}

output "nat_public_ip" {
  value = aws_eip.ionginx-eip.public_ip
}