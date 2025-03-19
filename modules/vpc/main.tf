# resource "aws_vpc" "application_vpc" {
#     cidr_block = var.vpc_cidr
#   tags = {
#     Name ="application_vpc"
#   }
# }

# resource "aws_subnet" "public_subnet" {
#     cidr_block = var.public_subnet_cidr
#     vpc_id = aws_vpc.application_vpc.id
#     map_public_ip_on_launch = true

#     tags = {
#     Name ="public_subnet"
#   }
# }

# resource "aws_subnet" "private_subnet" {
#     cidr_block = var.private_subnet_cidr
#     vpc_id = aws_vpc.application_vpc.id
#     tags = {
#     Name ="private_subnet"
#   }
# }

# resource "aws_internet_gateway" "application_igw" {
#     vpc_id = aws_vpc.application_vpc.id
#       tags = {
#     Name ="application_igw"
#   }
  
# }


# resource "aws_route_table" "application_route_table" {
#     vpc_id = aws_vpc.application_vpc.id

#     route {
#         cidr_block = "0.0.0.0/0"
#         gateway_id = aws_internet_gateway.application_igw.id
#     }
# }

# resource "aws_route_table_association" "public_subnet" {
#     route_table_id = aws_route_table.application_route_table.id
#     subnet_id = aws_subnet.public_subnet.id
  
# }

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = "us-east-1a"

  tags = {
    Name = "private"
  }
}

resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"  # Different CIDR for second subnet
  availability_zone = "us-east-1b"

  tags = {
    Name = "private-2"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "public"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}









































