resource "aws_cloudwatch_metric_alarm" "scale_up" {
  alarm_description   = "Monitor CPU utilization for Node Instance"
  alarm_actions       = [aws_autoscaling_policy.node-asg-policy1.arn]
  alarm_name          = "node_instance_scale_up"
  comparison_operator = "GreaterThanThreshold"
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  threshold           = "50"
  evaluation_periods  = "2"
  period              = "120"
  statistic           = "Average"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.node-app-asg.name
  }
}

resource "aws_cloudwatch_metric_alarm" "scale_down" {
  alarm_description   = "Monitor CPU utilization for Node Instance"
  alarm_actions       = [aws_autoscaling_policy.node-asg-policy2.arn]
  alarm_name          = "node_instance_scale_down"
  comparison_operator = "LessThanOrEqualToThreshold"
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  threshold           = "50"
  evaluation_periods  = "2"
  period              = "120"
  statistic           = "Average"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.node-app-asg.name
  }
}