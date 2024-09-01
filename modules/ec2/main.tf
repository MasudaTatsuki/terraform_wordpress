resource "aws_instance" "web" {
  ami                         = "ami-0c55b159cbfafe1f0"
  instance_type               = "t2.micro"
  # subnet_id                   = aws_subnet.public-a.id
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  # vpc_security_group_ids      = [aws_security_group.app.id]
  vpc_security_group_ids      = var.security_group_ids
  key_name                    = aws_key_pair.this.key_name

  private_ip = "10.1.1.1"

  tags = {
    Name = "wordpress-web"
  }

}

resource "aws_key_pair" "this" {
  key_name   = "key-name"
  public_key = file("../../wordpress.pub")
  
}