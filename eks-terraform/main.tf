provider "aws" {
  region = "ap-south-1"
}


module "aws_vpc" {
  source          = "github.com/erozedguy/AWS-VPC-terraform-module.git"
  networking      = var.networking
  security_groups = var.security_groups
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "xlrt-s3-bucket"
}
resource "aws_eks_cluster" "eks-cluster" {
  name     = "xlrt-eks-cluster"
  role_arn = aws_iam_role.EKSClusterRole.arn
  version  = "1.26"

  vpc_config {
    subnet_ids         = flatten([module.aws_vpc.public_subnets_id, module.aws_vpc.private_subnets_id])
    security_group_ids = flatten(module.aws_vpc.security_groups_id)
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy
  ]
}

resource "aws_eks_node_group" "nodes_group" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "xlrt_t3_micro-node_group"
  node_role_arn   = aws_iam_role.NodeGroupRole.arn
  subnet_ids      = flatten(module.aws_vpc.private_subnets_id)

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  ami_type       = "AL2_x86_64"
  instance_types = ["t3.micro"]
  capacity_type  = "ON_DEMAND"
  tags		 = {
		Name="xlrt-eks-workder-node"
		Product="xlrt"
		Environment="Production"
		}
  disk_size      = 20

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy
  ]
}

