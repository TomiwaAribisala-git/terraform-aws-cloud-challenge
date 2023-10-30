resource "aws_security_group" "alb-sg" { 
    name        = "alb-sg"
    vpc_id      = data.aws_vpc.default.id

    ingress {
        description      = "user access"
        from_port        = 80
        to_port          = 80
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
    }

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"] 
    }

    tags = {
        Name = "alb-sg"
    }
}

resource "aws_security_group" "server-sg" { 
    name        = "server-sg"
    vpc_id      = data.aws_vpc.default.id

    ingress {
        description      = "load balancer access"
        from_port        = 3000
        to_port          = 3000
        protocol         = "tcp"
        security_groups = [aws_security_group.alb-sg.id]
    }

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"] 
    }

    tags = {
        Name = "server-sg"
    }
}