output "elb_dns_name" {
    value = aws_lb.practice-lb.dns_name
    description = "The domain name of the load balancer"
}