resource "aws_instance" "web" {
  ami                         = "ami-06cd52961ce9f0d85"
  instance_type               = "t2.micro"
  # subnet_id                   = aws_subnet.public-a.id
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  # vpc_security_group_ids      = [aws_security_group.app.id]
  vpc_security_group_ids      = var.security_group_ids
  key_name                    = aws_key_pair.this.key_name

  private_ip = "10.1.1.16"

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              amazon-linux-extras install -y php8.2
              systemctl start httpd
              systemctl enable httpd
              
              # WordPress setup
              wget https://wordpress.org/latest.tar.gz
              tar -xzf latest.tar.gz
              cp -r wordpress/* /var/www/html/
              chown -R apache:apache /var/www/html/

              # Configure WordPress to use RDS MySQL
              cat <<EOT > /var/www/html/wp-config.php
              <?php
              define('DB_NAME', '${var.db_name}');
              define('DB_USER', '${var.db_user}');
              define('DB_PASSWORD', '${var.db_password}');
              define('DB_HOST', '${var.db_address}');
              define('DB_CHARSET', 'utf8');
              define('DB_COLLATE', '');
              \$table_prefix  = 'wp_';
              define('WP_DEBUG', false);
              if ( !defined('ABSPATH') )
                  define('ABSPATH', dirname(__FILE__) . '/');
              require_once(ABSPATH . 'wp-settings.php');
              ?>
              EOT

              systemctl restart httpd
              EOF

  tags = {
    Name = "wordpress-web"
  }

}

resource "aws_key_pair" "this" {
  key_name   = "key-name"
  public_key = file("/Users/masuda_tatsuki/Desktop/terraform_wordpress/wordpress.pub")
  
}