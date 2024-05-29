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

# Create VPC
resource "aws_vpc" "custom_vpc_test" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "custom_VPC_test"
  }
}

# Define availability zones
variable "availability_zones" {
  default = ["ap-south-1a"]
}

# Create Public Subnet
resource "aws_subnet" "custom_public_subnet" {
    count = length(var.availability_zones)
    vpc_id     = aws_vpc.custom_vpc_test.id
    cidr_block = "10.0.${count.index}.0/24"
    availability_zone = var.availability_zones[count.index] 
    map_public_ip_on_launch = true
    tags = {
    Name = "CustomPublicSubnet"
  }
}

# Create Private Subnet1
# resource "aws_subnet" "custom_private_subnet" {
#     count = length(var.availability_zones)
#     vpc_id     = aws_vpc.custom_vpc_test.id
#     cidr_block = "10.0.${count.index+20}.0/24"
#     availability_zone = var.availability_zones[count.index] 
# }

 # Create Internet Gateway
 resource "aws_internet_gateway" "custom_vpc_igw" {
   vpc_id = aws_vpc.custom_vpc_test.id
   tags = {
    Name = "MyCustomIGW"
  }
 }

 resource "aws_route" "custom_route" {
  route_table_id         = aws_vpc.custom_vpc_test.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.custom_vpc_igw.id
}


# # Create Route Table for Public Subnet
# resource "aws_route_table" "public_route_table" {
#   vpc_id = aws_vpc.custom_vpc_test.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.custom_vpc_igw.id
#   }
# }

# # Associate Public Subnet with Public Route Table
# resource "aws_route_table_association" "public_subnet_association" {
#   count = length(aws_subnet.custom_public_subnet)
#   subnet_id      = aws_subnet.custom_public_subnet[count.index].id
#   route_table_id = aws_route_table.public_route_table.id
# }