data "aws_ami" "latest-amazon-ami-image" {
    most_recent      = true
    owners           = ["amazon"]
    filter {
        name   = "name"
        values = ["al2023-ami-2023.2.20231016.0-kernel-6.1-x86_64"]
    }

    filter {
    name   = "root-device-type"
    values = ["ebs"]
    }
    
    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
}

resource "aws_launch_configuration" "node-app" {
  name_prefix     = "node-app-"
  image_id        = data.aws_ami.latest-amazon-ami-image.id
  instance_type   = var.instance_type
  user_data       = "${path.module}/user-data.sh"
  security_groups = [aws_security_group.server-sg.id]
  iam_instance_profile = aws_iam_instance_profile.instance-iam-profile.name
  lifecycle {
    create_before_destroy = true
  }
}