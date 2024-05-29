terraform {
  required_version = "1.7.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "bucket_creation" {
  bucket = "xlrt-app-bucket"
  acl  = "private"
  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_object" "folder1" {
  bucket = aws_s3_bucket.bucket_creation.bucket
  key    = "primary/"  
}

resource "aws_s3_bucket_object" "folder2" {
  bucket = aws_s3_bucket.bucket_creation.bucket
  key    = "temporary/"
}

resource "aws_s3_bucket_object" "folder3" {
  bucket = aws_s3_bucket.bucket_creation.bucket
  key    = "template/"
}