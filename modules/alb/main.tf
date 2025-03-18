resource "aws_vpc" "application_vpc" {
    cidr_block = "10.0.0.0/16"
  tags = {
    Name ="application_vpc"
  }
}

resource "aws_subnet" "public_subnet" {
    cidr_block = "10.0.0.1/24"
    vpc_id = aws_vpc.application_vpc.id
    map_public_ip_on_launch = true

    tags = {
    Name ="public_subnet"
  }
}

resource "aws_subnet" "private_subnet" {
    cidr_block = "10.0.0.2/24"
    vpc_id = aws_vpc.application_vpc.id
    tags = {
    Name ="private_subnet"
  }
}

resource "aws_internet_gateway" "application_igw" {
    vpc_id = aws_vpc.application_vpc.id
      tags = {
    Name ="application_igw"
  }
  
}


resource "aws_route_table" "application_route_table" {
    vpc_id = aws_vpc.application_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.application_igw.id
    }
}

resource "aws_route_table_association" "public_subnet" {
    route_table_id = aws_route_table.application_route_table.id
    subnet_id = aws_subnet.public_subnet.id
  
}









































