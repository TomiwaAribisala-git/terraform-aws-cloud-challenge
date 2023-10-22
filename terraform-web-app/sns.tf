resource "aws_sns_topic" "autoscaling_sns_topic" {
  name = "autoscaling_alerts_topic"

}

resource "aws_sns_topic_subscription" "sms_subscription" {
  topic_arn = aws_sns_topic.autoscaling_sns_topic.arn
  protocol  = "sms"
  endpoint  = "+2349037402028"
  filter_policy = jsonencode({
    event_source = ["aws.autoscaling"],
    event_name   = ["EC2_INSTANCE_LAUNCH", "EC2_INSTANCE_TERMINATE", "EC2_INSTANCE_LAUNCH_ERROR"],
  })
}