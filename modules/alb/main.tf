resource "aws_alb" "this" {
  name               = "wordpress-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.subnets
  ip_address_type    = "ipv4"

  tags = {
    Name = "wordpress-alb"
  }
}

resource "aws_lb_target_group" "this" {
  name             = "wordpress-lb-target-group"
  target_type      = "instance"
  protocol_version = "HTTP1"
  port             = 80
  protocol         = "HTTP"

  vpc_id = var.vpc_id

  tags = {
    Name = "wordpress-lb-target-group"
  }

  health_check {
    interval            = 30
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 5
    matcher             = "200,301"
  }
}

resource "aws_lb_target_group_attachment" "this" {
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = var.target_id
}