data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "public_subnet1" {
  vpc_id = data.aws_vpc.default.id
  id = var.subnet1_id
}

data "aws_subnet" "public_subnet2" {
  vpc_id = data.aws_vpc.default.id
  id = var.subnet2_id
}

resource "aws_subnet" "private_subnet1" {
  vpc_id                  = data.aws_vpc.default.id
  cidr_block              = var.private-subnet1-cidr-block
  availability_zone       = var.avail_zone1
  tags = {
    Name = "private_subnet1"
  }
}

resource "aws_subnet" "private_subnet2" {
  vpc_id                  = data.aws_vpc.default.id
  cidr_block              = var.private-subnet2-cidr-block
  availability_zone       = var.avail_zone2
  tags = {
    Name = "private_subnet2"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.eip.id
  subnet_id    = data.aws_subnet.public_subnet1.id
}

resource "aws_eip" "eip" {
  domain = "vpc"
}

resource "aws_route_table" "private_subnet1_route_table" {
  vpc_id = data.aws_vpc.default.id
  route {
    cidr_block = var.private-subnet1-route-table-cidr-block
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
}

resource "aws_route_table" "private_subnet2_route_table" {
  vpc_id = data.aws_vpc.default.id
  route {
    cidr_block = var.private-subnet2-route-table-cidr-block
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
}

resource "aws_route_table_association" "private_subnet1_route_table_association" {
    subnet_id = aws_subnet.private_subnet1.id 
    route_table_id = aws_route_table.private_subnet1_route_table.id 
}

resource "aws_route_table_association" "private_subnet2_route_table_association" {
    subnet_id = aws_subnet.private_subnet2.id 
    route_table_id = aws_route_table.private_subnet2_route_table.id 
}