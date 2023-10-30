output load_balancer_dns_name {
    value = aws_lb.node-alb.dns_name
}

output "sg_group_elb" {
  value = aws_security_group.alb-sg.id
}

output "sg_group_ec2" {
  value = aws_security_group.server-sg.id
}