resource "aws_db_instance" "this" {
  identifier          = "wordpress-mysql-instance"
  instance_class      = "db.t3.micro"
  engine              = "mysql"
  engine_version      = "8.0"
  username            = "user"
  password            = "wordpress-user"
  db_name             = "wordpress"
  allocated_storage   = 20
  backup_retention_period = 5
  publicly_accessible = false
  skip_final_snapshot = true
  vpc_security_group_ids      = var.security_group_ids
  db_subnet_group_name = var.db_subnet_group_name
}
