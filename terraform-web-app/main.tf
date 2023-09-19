terraform {
  backend "s3" {
    bucket = "terraform_state_bucket"
    key    = "terraform.tfstate"
    region = "eu-north-1"
    encrypt = true
    dynamodb_table = "terraform_state_bucket_lock"
  }
}

resource "aws_vpc" "main" {
    name = var.vpc_name
    cidr_block = var.vpc_cidr_block
}

resource "aws_subnet" "public_subnet" { 
    name = var.public_subnet_name
    vpc_id = aws_vpc.main.id
    cidr_block = var.public_subnet_cidr_block
    availability_zone = var.public_subnet_avail_zone
}

resource "aws_internet_gateway" "internet-gw" {
    vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.internet-gw.id 
    }
}

resource "aws_route_table_association" "public-subnet-route_table_association" {
    subnet_id = aws_subnet.public_subnet.id 
    route_table_id = aws_route_table.public_rt.id 
}

resource "aws_subnet" "private_subnet" { 
    name = var.private_subnet1_name
    vpc_id = aws_vpc.main.id
    cidr_block = var.private_subnet1_cidr_block
    availability_zone = var.private_subnet1_avail_zone
}

resource "aws_subnet" "private_subnet" { 
    name = var.private_subnet2_name
    vpc_id = aws_vpc.main.id
    cidr_block = var.private_subnet2_cidr_block
    availability_zone = var.private_subnet2_avail_zone
}

resource "aws_eip" "nat_eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.private_subnet.id
  depends_on = [aws_internet_gateway.internet-gw]
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

route {
  cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat_gw.id
}
}

resource "aws_route_table_association" "private_subnet_route_table_association" {
subnet_id = aws_subnet.private_subnet.id
route_table_id = aws_route_table.private_rt.id
}

resource "aws_security_group" "elb-sg" {
  vpc_id      = aws_vpc.main.id
  ingress {
        description      = "inbound traffic from users"
        from_port        = 3000
        to_port          = 3000
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
 }
}

resource "aws_security_group" "ec2-sg" { 
    vpc_id      = aws_vpc.main.id
    ingress {
        description      = "elb access"
        from_port        = 3000
        to_port          = 3000
        protocol         = "tcp"
        security_groups  = [aws_security_group.elb-sg.id]
    }

    ingress {
        description      = "ssh"
        from_port        = 22
        to_port          = 22
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
    } 

    egress {
        description      = "outbound traffic"
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"] 
    }
}



data "aws_ami" "latest-amazon-ami-image" {
    most_recent      = true
    owners           = ["amazon"]
    filter {
        name   = "name"
        values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
    }
    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
}

resource "aws_launch_configuration" "practice-instance" {
    ami                     = data.aws_ami.latest-amazon-ami-image.id 
    instance_type           = "t3.micro"
    user_data               = file("script.sh")
    subnet_id               = aws_subnet.practice-subnet-1.id 
    vpc_security_group_ids  = [aws_security_group.practice-sg.id] 
    availability_zone       = var.avail_zone
    key_name                = "gitlab"
    tags = {
        Name = "practice-instance"
    }
}