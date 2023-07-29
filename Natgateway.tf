# # Elastic IP
# resource "aws_eip" "wordpress-eip" {
#   instance = aws_instance.pub-instance-1a.id
#   vpc      = true
# }


# # Nat Gateway
# resource "aws_nat_gateway" "wordpress-nat-gw" {
#   allocation_id = aws_eip.wordpress-eip.id
#   subnet_id     = aws_subnet.subnet-1-1a.id

#   tags = {
#     Name = "wordpress-nat-gw"
#   }
#   depends_on = [aws_internet_gateway.wordpress-vpc-IG]
# }