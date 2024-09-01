resource "aws_subnet" "public-a" {
  vpc_id                  = var.vpc_id
  cidr_block              = "10.1.1.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "Wordpress-Publicsubnet-1a"
  }
}

resource "aws_subnet" "private-a" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.1.2.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "Wordpress-PrivateSubnet-1a"
  }
}

resource "aws_subnet" "private-d" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.1.3.0/24"
  availability_zone = "ap-northeast-1d"

  tags = {
    Name = "Wordpress-PrivateSubnet-1d"
  }
}

resource "aws_db_subnet_group" "this" {
  name        = "wordpress-db-subnet"
  description = "subnet for db"
  subnet_ids  = [aws_subnet.private-a.id, aws_subnet.private-d.id]

  tags = {
    Name = "wordpress-db-subnet"
  }
}