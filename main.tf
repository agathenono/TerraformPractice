resource "aws_vpc" "myvpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "myvpc"
  }
}

resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "myvpc"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "eu-west-2c"

  tags = {
    Name = "subnet1"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.8.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "eu-west-2b"

  tags = {
    Name = "subnet2"
  }
}

resource "aws_subnet" "subnet3" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "eu-west-2a"

  tags = {
    Name = "subnet3"
  }
}


resource "aws_subnet" "public_subnet6" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-west-2c"

  tags = {
    Name = "subnet6"
  }
}

resource "aws_subnet" "public_subnet5" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-west-2b"

  tags = {
    Name = "subnet5"
  }
}

resource "aws_subnet" "public_subnet4" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.7.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-west-2a"

  tags = {
    Name = "subnet4"
  }
}


resource "aws_route_table" "myroute" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block     = "10.0.8.0/24"
    nat_gateway_id = aws_nat_gateway.nat_gateway1.id
  }

  route {
    cidr_block     = "10.0.2.0/24"
    nat_gateway_id = aws_nat_gateway.nat_gateway2.id
  }

  route {
    cidr_block     = "10.0.4.0/24"
    nat_gateway_id = aws_nat_gateway.nat_gateway3.id
  }

}

resource "aws_route_table_association" "myrta2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.myroute.id
}

resource "aws_route_table_association" "myrta1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.myroute.id
}

resource "aws_route_table_association" "myrta3" {
  subnet_id      = aws_subnet.subnet3.id
  route_table_id = aws_route_table.myroute.id
}

resource "aws_eip" "my_nat_eip1" {}

resource "aws_nat_gateway" "nat_gateway1" {
  allocation_id = aws_eip.my_nat_eip1.id
  subnet_id     = aws_subnet.public_subnet6.id # Choose one of the public subnets
}

resource "aws_eip" "my_nat_eip2" {}

resource "aws_nat_gateway" "nat_gateway2" {
  allocation_id = aws_eip.my_nat_eip2.id
  subnet_id     = aws_subnet.public_subnet5.id # Choose one of the public subnets
}

resource "aws_eip" "my_nat_eip3" {}

resource "aws_nat_gateway" "nat_gateway3" {
  allocation_id = aws_eip.my_nat_eip3.id
  subnet_id     = aws_subnet.public_subnet4.id # Choose one of the public subnets
}





