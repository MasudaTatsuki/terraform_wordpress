resource "aws_rds_cluster" "this" {
  cluster_identifier      = "wordpress-aurora-cluster"
  engine                  = "aurora-mysql"
  engine_version          = "8.0.mysql_aurora.3.07.0"
  master_username         = "user"
  master_password         = "wordpress-user"
  skip_final_snapshot     = true
  backup_retention_period = 5
}

resource "aws_rds_cluster_instance" "this" {
  identifier          = "wordpress-aurora-instance"
  cluster_identifier  = aws_rds_cluster.this.id
  instance_class      = "db.t2.micro"
  engine              = "aurora-mysql"
  engine_version      = "8.0.mysql_aurora.3.07.0"
  publicly_accessible = false
}