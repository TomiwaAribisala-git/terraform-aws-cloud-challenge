data "aws_ami" "latest-amazon-ami-image" {
    most_recent      = true
    owners           = ["amazon"]
    filter {
        name   = "name"
        values = ["al2023-ami-2023.2.20231016.0-kernel-6.1-hvm-*-x86_64-gp2"]
    }
    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
}

data "user_data_file" "startup" {
 template = file("ec2-user-data.sh")
}

resource "aws_launch_configuration" "node-app" {
  name_prefix     = "node-app-"
  image_id        = data.aws_ami.latest-amazon-ami-image.id
  instance_type   = var.instance_type
  user_data       = data.user_data_file_.startup.rendered
  security_groups = [aws_security_group.server-sg.id]
  iam_instance_profile = aws_iam_instance_profile.instance-iam-profile.name
  lifecycle {
    create_before_destroy = true
  }
}