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
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidr
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}









































