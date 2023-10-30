output "load_balancer_dns_name" {
  description = "DNS name of load balancer"
  value = module.terraform-web-app.load_balancer_dns_name
}

output "sg_group_elb" {
  description = "security group of load balancer"
  value = module.terraform-web-app.sg_group_elb
}

output "sg_group_ec2" {
  description = "security group of EC2 Instance"
  value = module.terraform-web-app.sg_group_ec2
}