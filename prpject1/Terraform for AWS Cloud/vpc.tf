# Create VPC
resource "aws_vpc" "custom_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = "true"
  
  tags = {
    Name = "custom_vpc"
  }
}

# Public subnets in custom VPC
resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.custom_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = "true"
  
  tags = {
    Name = "public_subnet_1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id     = aws_vpc.custom_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = "true"
  
  tags = {
    Name = "public_subnet_2"
  }
}

resource "aws_subnet" "public_subnet_3" {
  vpc_id     = aws_vpc.custom_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1c"
  map_public_ip_on_launch = "true"
  
  tags = {
    Name = "public_subnet_3"
  }
}

# private subnets in custom VPC

resource "aws_subnet" "private_subnet_1" {
  vpc_id     = aws_vpc.custom_vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-1a"
  
  tags = {
    Name = "private_subnet_1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id     = aws_vpc.custom_vpc.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "us-east-1b"
  
  tags = {
    Name = "private_subnet_2"
  }
}

resource "aws_subnet" "private_subnet_3" {
  vpc_id     = aws_vpc.custom_vpc.id
  cidr_block = "10.0.6.0/24"
  availability_zone = "us-east-1c"
  
  tags = {
    Name = "private_subnet_3"
  }
}

# Internet gateway on custom VPC

resource "aws_internet_gateway" "custom_gw" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = "custom_gw"
  }
}

# Routing table
resource "aws_route_table" "custom_route_table" {
  vpc_id = aws_vpc.custom_vpc.id

  # since this is exactly the route AWS will create, the route will be adopted
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.custom_gw.id
  }

  tags = {
    name = "custom_route_table"
  }
}

# Routing table association

resource "aws_route_table_association" "custom_route_associate_1a" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.custom_route_table.id
}

resource "aws_route_table_association" "custom_route_associate_1b" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.custom_route_table.id
}

resource "aws_route_table_association" "custom_route_associate_1c" {
  subnet_id      = aws_subnet.public_subnet_3.id
  route_table_id = aws_route_table.custom_route_table.id
}

