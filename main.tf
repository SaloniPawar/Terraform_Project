# Manual Approach of creating Instances :

#### instances in AZ-1a

## Public Instance in subnet-1-1a
resource "aws_instance" "pub-instance-1a" {
  ami           = "ami-025e38a274e14cb2f"
  instance_type = "t2.micro"
  key_name = "demo-key"
  subnet_id = aws_subnet.subnet-1-1a.id
  associate_public_ip_address = "true"
  #security_groups = [aws_security_group.allow_80.id,aws_security_group.allow_22.id]
  vpc_security_group_ids = [aws_security_group.allow_80.id,aws_security_group.allow_22.id]
  tags = {
    Name = "pub-instance-1a"
  }
}

## Private Instance in subnet-2-1a
resource "aws_instance" "private-instance-1a" {
  ami           = "ami-025e38a274e14cb2f"
  instance_type = "t2.micro"
  key_name = "terraform-proj-key"
  subnet_id = aws_subnet.subnet-2-1a.id
  #security_groups = [aws_security_group.allow_80.id,aws_security_group.allow_22.id]
  vpc_security_group_ids = [aws_security_group.allow_80.id,aws_security_group.allow_22.id]
  tags = {
    Name = "private-instance-1a"
  }
}

#### instances in AZ-1b

## Public Instance in subnet-1-1b
# resource "aws_instance" "pub-instance-1b" {
#   ami           = "ami-025e38a274e14cb2f"
#   instance_type = "t2.micro"
#   key_name = "demo-key"
#   subnet_id = aws_subnet.subnet-1-1b.id
#   associate_public_ip_address = "true"
#   #security_groups = [aws_security_group.allow_80.id,aws_security_group.allow_22.id]
#   vpc_security_group_ids = [aws_security_group.allow_80.id,aws_security_group.allow_22.id]
#   tags = {
#     Name = "pub-instance-1b"
#   }
# }

## Private Instance in subnet-2-1b
# resource "aws_instance" "private-instance-1b" {
#   ami           = "ami-025e38a274e14cb2f"
#   instance_type = "t2.micro"
#   key_name = "terraform-proj-key"
#   subnet_id = aws_subnet.subnet-2-1b.id
#   #security_groups = [aws_security_group.allow_80.id,aws_security_group.allow_22.id]
#   vpc_security_group_ids = [aws_security_group.allow_80.id,aws_security_group.allow_22.id]
#   tags = {
#     Name = "private-instance-1b"
#   }
# }


# Creating key-pair with SSH for private instance
resource "aws_key_pair" "terraform-proj-key" {
  key_name   = "terraform-proj-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDXUuR/z96rdEdG6Ml9p6Xd3a4sZOaN0+k0ecBubuU0YT74o6cuies7Lir2VK3JQkdkm1VEQLBbgz++aDs2OE6rXZHiWPu2zrq9j7Ly8d+lMd+h3pmYAgTLL2Xml2tvZAjrnMCrM3mEcSU7DN+Q8O4AnjjVjhXsabHKjxKtYKCHLGQZKimnQ7ZUzUCJ07XKXcVP53mdyT7EgBEFBFXMHyOdGnp1vwgConD1V5S50PnPst/GFSMoMd2tWfjY/74vj43MAqPYEFTTWx5tJ0DKRNyZfV+ZJWpF8eQ1WFeW0mu2esv6qS5OKoPrFDn4AbtRF+H5OtxPmhESTt9YGNow9m4ufCkI5bWfQlesJbo7Fe3/HfSh/8AzfSJO6mx8xQmU7zuFu/vATUzMLffdjfPiIUCXY8Wl5r8nKyAQlqmBlCFHopQx3gdCnej2D9JhAPjwrc2B2LQGd5f71B4FTsU7+goBSm6tDKrgAR8hgd5/TMkz2e1330BzybPw++TN0XizsjE= SALONI@LAPTOP-SA7V2SKH"
}




