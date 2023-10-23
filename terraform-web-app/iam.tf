resource "aws_iam_instance_profile" "instance-iam-profile" {
  name = "ec2_profile"
  role = aws_iam_role.instance-iam-role.name
}

resource "aws_iam_role" "instance-iam-role" {
  name        = "instance-ssm-role"
  description = "The role for the node-app instance"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com",
        },
      },
    ],
  })
}

resource "aws_iam_role_policy_attachment" "instance-ssm-policy" {
  role       = aws_iam_role.instance-iam-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_sns_topic_policy" "default" {
  arn = aws_sns_topic.autoscaling_sns_topic.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

data "aws_iam_policy_document" "sns_topic_policy" {
  statement {
    actions = [
      "SNS:Publish",
    ]
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["autoscaling.amazonaws.com"]
    }
    resources = [
      aws_sns_topic.autoscaling_sns_topic.arn
    ]
  }
}