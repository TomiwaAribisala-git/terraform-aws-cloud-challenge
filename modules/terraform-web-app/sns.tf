resource "aws_sns_topic" "autoscaling_sns_topic" {
  name = "autoscaling_sns_topic"
}

resource "aws_sns_topic_subscription" "sms_subscription" {
  topic_arn = aws_sns_topic.autoscaling_sns_topic.arn
  protocol  = "sms"
  endpoint  = "+2349037402028"
}