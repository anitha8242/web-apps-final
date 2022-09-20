#creating VPC
resource "aws_vpc" "demovpc" {
  cidr_block = "192.168.0.0/16"

  tags = {
    Name = "tf- VPC"
  }
}
# Creating Internet Gateway
resource "aws_internet_gateway" "demogateway" {
  vpc_id = aws_vpc.demovpc.id
  tags = {
    Name = "tf-IGW"
  }
}
# Creating 1st web subnet
resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = aws_vpc.demovpc.id
  cidr_block              = "192.168.100.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "tf-public-sn-1"
  }
}
# Creating 2nd web subnet
resource "aws_subnet" "public-subnet-2" {
  vpc_id                  = aws_vpc.demovpc.id
  cidr_block              = "192.168.200.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1d"
  tags = {
    Name = "tf-public-sn-2"
  }
}
# Creating Route Table
resource "aws_route_table" "Publicroute" {
  vpc_id = aws_vpc.demovpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demogateway.id
  }
  tags = {
    Name = "tf-rt"
  }
}
# Association Route Table
resource "aws_route_table_association" "route-sub" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.Publicroute.id
}
# Association Route Table
resource "aws_route_table_association" "route-sub2" {
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.Publicroute.id
}
