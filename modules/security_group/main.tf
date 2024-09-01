resource "aws_security_group" "app" {
  name        = "Wordpress-Web-SG"
  description = "Wordpress-Web-SG"
  vpc_id      = var.vpc_id

  tags = {
    Name = "Wordpress-Web-SG"
  }
}

resource "aws_security_group" "db" {
  name        = "Wordpress-DB-SG"
  description = "Wordpress-DB-SG"
  vpc_id      = var.vpc_id

  tags = {
    Name = "Wordpress-DB-SG"
  }
}

resource "aws_security_group_rule" "ssh" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.app.id
}

resource "aws_security_group_rule" "http" {
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.app.id
}

resource "aws_security_group_rule" "mysql" {
  type      = "ingress"
  from_port = 3306
  to_port   = 3306
  protocol  = "tcp"

  source_security_group_id = aws_security_group.app.id

  security_group_id = aws_security_group.db.id
}

resource "aws_security_group_rule" "all" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.app.id
}

output "app_sg_id" {
  value = aws_security_group.app.id
}