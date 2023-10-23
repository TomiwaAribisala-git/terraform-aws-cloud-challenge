resource "aws_lb" "node-alb" {
  name               = var.alb-name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb-sg.id]
  subnets            = [data.aws_subnet.public_subnet1.id, data.aws_subnet.public_subnet2.id]
  enable_deletion_protection = false
  tags = {
    name = "node-alb"
  }
}

resource "aws_lb_listener" "node-listener" {
  load_balancer_arn = aws_lb.node-alb.arn
  port              = var.node-ls-port
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.node-lb-tg.arn
  }
}

resource "aws_lb_target_group" "node-lb-tg" {
  name        = var.node-tg-name
  port        = var.node-tg-port
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.default.id
}
