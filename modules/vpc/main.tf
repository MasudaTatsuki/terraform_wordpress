resource "aws_vpc" "main" {
  cidr_block       = "10.1.0.0/16"
  instance_tenancy = "default"

  enable_dns_hostnames = "false"
  enable_dns_support   = "true"
  tags = {
    Name = "Wordpress_vpc"
  }
}

# resource "aws_internet_gateway" "internet_gateway" {
#   vpc_id = aws_vpc.main.id

#   tags = {
#     Name = "Wordpress-InternetGateway"
#   }
# }

# resource "aws_route_table" "rote_table" {
#   vpc_id = aws_vpc.main.id

#   route = [{
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.internet_gateway.id
#     # gateway_id = var.gateway_id
#   }]
# }

# resource "aws_route_table_association" "route_table_association" {
#   # subnet_id      = aws_subnet.public-a.id
#   subnet_id      = var.subnet_id
#   route_table_id = aws_route_table.rote_table.id
# }

