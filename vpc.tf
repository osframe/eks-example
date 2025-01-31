resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${var.project_name}-vpc"
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_subnet" "my_subnet_public" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "${var.region}a"

  tags = {
    Name = "${var.project_name}-public"
  }
}

resource "aws_subnet" "my_subnet_private" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.2.0/24"
  map_public_ip_on_launch = false
  availability_zone = "${var.region}a"

  tags = {
    Name = "${var.project_name}-private"
  }
}

resource "aws_route_table" "my_route_table_public" {
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route_table_association" "my_rta_pub" {
  subnet_id      = aws_subnet.my_subnet_public.id
  route_table_id = aws_route_table.my_route_table_public.id
}

resource "aws_route" "my_route_internet_access" {
  route_table_id         = aws_route_table.my_route_table_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_igw.id
}

resource "aws_nat_gateway" "my_nat_gw" {
  allocation_id = aws_eip.my_eip.id
  subnet_id     = aws_subnet.my_subnet_public.id
}

resource "aws_eip" "my_eip" {
  vpc = true
}

resource "aws_route_table" "my_route_table_private" {
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route_table_association" "my_rta_private" {
  subnet_id      = aws_subnet.my_subnet_private.id
  route_table_id = aws_route_table.my_route_table_private.id
}

resource "aws_route" "my_route_private_nat" {
  route_table_id         = aws_route_table.my_route_table_private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.my_nat_gw.id
}
