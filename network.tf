# creating VPC for webapp creator : saloni
resource "aws_vpc" "wordpress-vpc" {
  cidr_block = "10.10.0.0/16"

  tags = {
    Name = "Wordpress-VPC"
  }
}

# Public subnet in 1a
resource "aws_subnet" "subnet-1-1a" {
  vpc_id     = aws_vpc.wordpress-vpc.id
  cidr_block = "10.10.1.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "Subnet-1-1a"
  }
}

# Private subnet in 1a
resource "aws_subnet" "subnet-2-1a" {
  vpc_id     = aws_vpc.wordpress-vpc.id
  cidr_block = "10.10.2.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "Subnet-2-1a"
  }
}

# Public subnet in 1b
resource "aws_subnet" "subnet-1-1b" {
  vpc_id     = aws_vpc.wordpress-vpc.id
  cidr_block = "10.10.3.0/24"
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "Subnet-1-1b"
  }
}

# Private subnet in 1b
resource "aws_subnet" "subnet-2-1b" {
  vpc_id     = aws_vpc.wordpress-vpc.id
  cidr_block = "10.10.4.0/24"
  availability_zone = "ap-south-1b"
  
  tags = {
    Name = "Subnet-2-1b"
  }
}

# Security Group Port 80
resource "aws_security_group" "allow_80" {
  name        = "allow_port-80"
  description = "Allow http inbound traffic"
  vpc_id      = aws_vpc.wordpress-vpc.id

  ingress {
    description      = "http traffic"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_http"
  }
}

# Security Group Port 22
resource "aws_security_group" "allow_22" {
  name        = "allow_port-22"
  description = "Allow ssh inbound traffic"
  vpc_id      = aws_vpc.wordpress-vpc.id
  ingress {
    description      = "ssh traffic"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

# Internet Gateway (IG) for VPC
resource "aws_internet_gateway" "wordpress-vpc-IG" {
  vpc_id = aws_vpc.wordpress-vpc.id

  tags = {
    Name = "wordpress-vpc-IG"
  }
}

# Route Table (RT) 
resource "aws_route_table" "wordpress-public-RT" {
  
  vpc_id = aws_vpc.wordpress-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.wordpress-vpc-IG.id
  }
  tags = {
    Name = "wordpress-public-RT"
  }
}

# Route Table (RT) Association
# Making subnet-1-1a as PUBLIC
resource "aws_route_table_association" "wordpress-public-RT-association-subnet-1-1a" {
  subnet_id      = aws_subnet.subnet-1-1a.id
  route_table_id = aws_route_table.wordpress-public-RT.id
}

# Making subnet-1-1b as PUBLIC
resource "aws_route_table_association" "wordpress-public-RT-association-subnet-1-1b" {
  subnet_id      = aws_subnet.subnet-1-1b.id
  route_table_id = aws_route_table.wordpress-public-RT.id
}



