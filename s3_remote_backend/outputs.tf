output "s3_bucket_arn" {
  description = "The ARN of the S3 Bucket"
  value = aws_s3_bucket.terraform-cloud-challenge-state.arn
}
/*
output "dynamodb_table_name" {
  description = "The name of the DynamoDB Table"
  value = aws_dynamodb_table.terraform-cloud-challenge-state-lock.name
}
*/