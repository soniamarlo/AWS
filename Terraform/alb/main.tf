resource "aws_lb" "nginx_alb-sonia" {
  name               = "${var.alb_name}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["sg-0700c3f20bebd1fa9"]

  
  subnets            = [element(data.aws_subnets.default.ids, 0), element(data.aws_subnets.default.ids, 1)]

  enable_deletion_protection = false
  idle_timeout               = 60
}

resource "aws_lb_target_group" "nginx_tg-sonia" {
  name     = "nginx-alb-dev-sonia-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id
  target_type = "ip"

  health_check {
    enabled             = true
    interval            = 30
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = "200"
  }
}

resource "aws_lb_listener" "nginx_listener-sonia" {
  load_balancer_arn = aws_lb.nginx_alb-sonia.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx_tg-sonia.arn
  }
}