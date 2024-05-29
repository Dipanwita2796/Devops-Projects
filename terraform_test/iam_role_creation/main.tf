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

# # create the iam role
# resource "aws_iam_role" "ec2_iam_role_creation" {
#   name = "ec2iamroletest"
#   assume_role_policy = jsonencode({
#     "Version" : "2012-10-17",
#     "Statement" : [{
#       "Effect" : "Allow",
#       "Principal" : {
#         "Service" : "ec2.amazonaws.com"
#       },
#       "Action" : "sts:AssumeRole"
#     }]
#   })
# }


# #attach the policy to the role
# resource "aws_iam_role_policy_attachment" "s3_full_access" {
#   role       = aws_iam_role.ec2_iam_role_creation.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
# }

# resource "aws_iam_role_policy_attachment" "ec2_full_access" {
#   role       = aws_iam_role.ec2_iam_role_creation.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
# }

# resource "aws_iam_role_policy_attachment" "ecr_full_access" {
#   role       = aws_iam_role.ec2_iam_role_creation.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
# }



# 
# create the iam role
resource "aws_iam_role" "ec2_iam_role_creation" {
  name               = "ec2iamroletestdipanwita"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [{
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }]
  })
}

#create the iam policy
resource "aws_iam_policy" "ec2_iam_policy_creation" {
  name        = "ec2iampolicytest"
  description = "An iam policy creation example policy"
  policy      = "${file("policy.json")}"
}

#attach the policy to the role
resource "aws_iam_role_policy_attachment" "iam_policy_attachment" {
  role       = aws_iam_role.ec2_iam_role_creation.name
  policy_arn = aws_iam_policy.ec2_iam_policy_creation.arn
}