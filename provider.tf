terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.66.0"
    }
  }

  backend "s3" {
    bucket = "khalidskaws82s-dev1"
    key    = "cicd-tools"
    region = "us-east-1"
    dynamodb_table = "khalidskaws82s-dev1"
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}