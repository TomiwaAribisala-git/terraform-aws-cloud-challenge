resource "aws_autoscaling_group" "node-app-asg" {
  name                 = var.asg-name
  min_size             = 1
  max_size             = 4
  desired_capacity     = 1
  health_check_type    = "ELB"
  force_delete         = true
  launch_configuration = aws_launch_configuration.node-app.name
  vpc_zone_identifier  = [aws_subnet.private_subnet1.id, aws_subnet.private_subnet2.id]
  lifecycle { 
    ignore_changes = [desired_capacity, target_group_arns]
  }
}

resource "aws_autoscaling_attachment" "node-asg-attachment" {
  autoscaling_group_name = aws_autoscaling_group.node-app-asg.id
  lb_target_group_arn    = aws_lb_target_group.node-lb-tg.arn
}

resource "aws_autoscaling_policy" "node-asg-policy1" {
  name                   = "node-asg-policy1"
  scaling_adjustment     = 2
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.node-app-asg.name
}

resource "aws_autoscaling_policy" "node-asg-policy2" {
  name                   = "node-asg-policy2"
  scaling_adjustment     = -2
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 120
  autoscaling_group_name = aws_autoscaling_group.node-app-asg.name
}

resource "aws_autoscaling_notification" "node-app-asg-notifications" {
  group_names = [
    aws_autoscaling_group.node-app-asg.name
  ]
  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
  ]
  topic_arn = aws_sns_topic.autoscaling_sns_topic.arn
}