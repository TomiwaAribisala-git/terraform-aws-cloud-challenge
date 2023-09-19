output "elb_dns_name" {
    value = aws_lb.practice-lb.dns_name
    description = "The domain name of the load balancer"
}

output "sg_group_elb" {
    value = aws_security_group.elb-sg.id
    description = "The security group of the Load Balancer"
}

output "sg_group_ec2" {
    value = aws_security_group.ec2-sg.id
    description = "The security group of the EC2 Instance"
}