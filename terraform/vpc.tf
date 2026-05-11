resource "aws_vpc" "voting_app" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "voting-app-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.voting_app.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "voting-app-public-subnet"
  }
}

resource "aws_internet_gateway" "voting_app" {
  vpc_id = aws_vpc.voting_app.id

  tags = {
    Name = "voting-app-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.voting_app.id

  route {
    cidr_block      = "0.0.0.0/0"
    gateway_id      = aws_internet_gateway.voting_app.id
  }

  tags = {
    Name = "voting-app-public-rt"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

data "aws_availability_zones" "available" {
  state = "available"
}
