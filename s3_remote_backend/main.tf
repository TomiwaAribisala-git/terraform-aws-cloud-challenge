terraform {
  cloud {
    organization = "tomiwa-terraform-bootcamp-2023"

    workspaces {
      name = "terraform-cloud-challenge-s3-state"
    }
  }
}

resource "aws_s3_bucket" "terraform-cloud-challenge-state" {
  bucket = var.bucket_name
  /*
  lifecycle {
    prevent_destroy = true
  }
  */
}

resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform-cloud-challenge-state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.terraform-cloud-challenge-state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.terraform-cloud-challenge-state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

/*
resource "aws_dynamodb_table" "terraform-cloud-challenge-state-lock" {
  name           = var.dynamodb_table_name
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
*/