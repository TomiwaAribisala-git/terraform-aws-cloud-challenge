variable alb-name {
    description = "name of the application load balancer"
    type = string
}

variable node-ls-port {
    description = "load balancer listener port"
    type = number
}

variable node-tg-name {
    description = "name of load balancer target group"
    type = string
}

variable node-tg-port {
    description = "load balancer target group port"
    type = number
}

variable subnet1_id {
    description = "ID of the public_subnet1"
    type = string
}
variable subnet2_id {
    description = "ID of the public_subnet2"
    type = string
}

variable avail_zone1 {
    description = "availability zone of private_subnet1"
    type = string
}
variable private-subnet1-cidr-block {
    description = "CIDR block of private_subnet1"
    type = string
}

variable avail_zone2 {
    description = "availability zone of private_subnet1"
    type = string
}
variable private-subnet2-cidr-block {
    description = "CIDR block of private_subnet2"
    type = string
}

variable private-subnet1-route-table-cidr-block {
    description = "CIDR block of private_subnet1 route_table to NAT Gateway"
    type = string
}
variable private-subnet2-route-table-cidr-block {
    description = "CIDR block of private_subnet2 route_table to NAT Gateway"
    type = string
}

variable asg-name {
    description = "name of autoscaling group"
    type = string
}

variable instance_type {
    description = "ec2 instance type"
    type = string
}