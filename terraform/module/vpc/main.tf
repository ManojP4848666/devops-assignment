#VPC

resource "aws_vpc" "main" {
    cidr_block = var.cidr_range
    tags = {
        Name = "manoj-vpc"
    }
}

#PUBLIC SUBNET

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.10.1.0/24"
    map_public_ip_on_launch = true
    tags = {
        Name = "public-subnet"
    }
}

#PRIVATE SUBNET

resource "aws_subnet" "private" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.10.2.0/24"
    tags = {
        Name = "private-subnet"
    }
}

#PRIVATE SUBNET 2

resource "aws_subnet" "private_2" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.10.3.0/24"
    tags = {
        Name = "private-subnet-2"
    }
}

#INTERNET GATEWAY

resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.main.id
}

#PUBLIC ROUTE TABLE

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.main.id
}

#PRIVATE ROUTE TABLE

resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.main.id
}

#ROUTE TO INTERNET

resource "aws_route" "internet_access" {
    route_table_id = aws_route_table.public_rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
}

#ASSOCIATE PUBLIC SUBNET

resource "aws_route_table_association" "public_assoc" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.public_rt.id
}