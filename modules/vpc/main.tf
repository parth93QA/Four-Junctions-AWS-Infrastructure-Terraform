resource "aws_vpc" "ionginx-vpc" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "${var.vpc_name}"
  }
}

resource "aws_subnet" "ionginx-public-subnet" {
  vpc_id = aws_vpc.ionginx-vpc.id
  count = length(var.vpc_public_subnet_cidr)
  cidr_block = element(var.vpc_public_subnet_cidr, count.index)
  availability_zone = element(var.azs, count.index)
  map_public_ip_on_launch = false
  tags = {
    Name = "ionginx-vpc-public-subnet"
  }
}

resource "aws_subnet" "ionginx-private-subnet" {
  vpc_id = aws_vpc.ionginx-vpc.id
  count = length(var.vpc_private_subnet_cidr)
  cidr_block = element(var.vpc_private_subnet_cidr, count.index)
  availability_zone = element(var.azs, count.index)
  map_public_ip_on_launch = false
  tags = {
    Name = "ionginx-vpc-private-subnet"
  }
}

resource "aws_internet_gateway" "ionginx-igw" {
    vpc_id = aws_vpc.ionginx-vpc.id
    tags = {
      Name = "ionginx-vpc-igw"
    }
}

resource "aws_eip" "ionginx-eip" {
  domain = "vpc"
  depends_on = [ aws_internet_gateway.ionginx-igw ]
}

resource "aws_nat_gateway" "ionginx-nat-gw" {
  allocation_id = aws_eip.ionginx-eip.id
  subnet_id = element(aws_subnet.ionginx-public-subnet.*.id, 0)
  tags = {
    Name = "ionginx-nat-gateway"
  }
}

resource "aws_route_table" "ionginx-public-rt" {
  vpc_id = aws_vpc.ionginx-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ionginx-igw.id
  }
  tags = {
    Name = "ionginx-public-rt"
  }
}

resource "aws_route_table" "ionginx-private-rt" {
  vpc_id = aws_vpc.ionginx-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ionginx-nat-gw.id
  }
  tags = {
    Name = "ionginx-private-rt"
  }
}

resource "aws_route_table_association" "ionginx-public-rt-association" {
  count = length(var.vpc_public_subnet_cidr)
  subnet_id = element(aws_subnet.ionginx-public-subnet[*].id, count.index)
  route_table_id = aws_route_table.ionginx-public-rt.id
}

resource "aws_route_table_association" "ionginx-private-rt-association" {
  count = length(var.vpc_private_subnet_cidr)
  subnet_id = element(aws_subnet.ionginx-private-subnet[*].id,count.index)
  route_table_id = aws_route_table.ionginx-private-rt.id
}