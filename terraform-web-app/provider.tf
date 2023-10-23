terraform {
  backend "s3" {
    bucket         = "terraform-cloud-challenge-state-bucket"
    key            = "global/s3/terraform.tfstate"
    region         = "eu-north-1"
    #encrypt        = true
    #dynamodb_table = "terraform-cloud-challenge-state-lock"
  }
}


terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.22.0"
    }
  }
}

provider "aws" {
    region = "eu-north-1"
}