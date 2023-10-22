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

resource "aws_iam_role" "autoscaling_sns_role" {
  name = "AutoScalingSNSTopicRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "autoscaling.amazonaws.com",
        },
      },
    ],
  })
}

resource "aws_iam_policy" "autoscaling_sns_policy" {
  name        = "AutoScalingSNSTopicPolicy"
  description = "IAM policy to allow Auto Scaling to publish to the SNS topic"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sns:Publish",
        Effect = "Allow",
        Resource = aws_sns_topic.autoscaling_sns_topic.arn,
      },
    ],
  })
}

resource "aws_iam_policy_attachment" "autoscaling_sns_policy_attachment" {
  name       = "AutoScalingSNSTopicAttachment" 
  policy_arn = aws_iam_policy.autoscaling_sns_policy.arn
  roles      = [aws_iam_role.autoscaling_sns_role.name]
}