#region where resource will be created
variable "region" {
  description = "AWS Region to deploy resources"
  default     = "ap-south-1"
}

#iam role to be assigned to all ec2 instances
variable "role_name" {
  description = "Role to be attached to EC2 instnace"
  default     = "applications-iam-role"
}

#CIDR range with which VPC will be created
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

#name of the custom vpc created
variable "vpc_name" {
  description = "Name for the vpc"
  default     = "xlrt-custom-vpc"
}

#CIDR range for the public subnet created within vpc
variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  default     = "10.0.1.0/24"
}

#availability zone for the public subnet
variable "availability_zone" {
  description = "AZ to create public subnet"
  default     = "ap-south-1a"
}

#public subnet name
variable "public_subnet_name" {
  description = "Name of the public subnet"
  default     = "xlrt-custom-public-subnet"
}

#name of the internet gateway to be created
variable "igw_name" {
  description = "Name of the internet gateway"
  default     = "xlrt-custom-igw"
}

#key pair to be attached to all ec2
variable "key_pair_name" {
  description = "key pair to be attached to EC2"
  default     = "xlrt-key"
}


#--------------------------------------------APP SERVER--------------------------------------------#

#size of the EBS volume to be attached to app server
variable "ebs_app_server_size" {
  description = "Total size of the EBS volume for app server"
  default     = 200
}

#name of the EBS volume attached to app server
variable "ebs_app_server_name" {
  description = "Name of the EBS volume for app server"
  default     = "ebs-xlrt-app-server"
}

#instance type of the app server
variable "app_server_instance_type" {
  description = "App server instance type"
  default     = "r5a.4xlarge"
}

#name of the app server
variable "app_server_name" {
  description = "App server name"
  default     = "xlrt-app-server"
}

#name of the security group attached to app server 
variable "app_server_security_group" {
  description = "App server security group"
  default     = "xlrt-app-server-security-group"
}




#--------------------------------------------MODEL SERVER--------------------------------------------#

#size of the EBS volume to be attached to model server
variable "ebs_model_server_size" {
  description = "Total size of the EBS volume for model server"
  default     = 100
}

#name of the EBS volume attached to model server
variable "ebs_model_server_name" {
  description = "Name of the EBS volume for model server"
  default     = "ebs-xlrt-model-server"
}

#instance type of the model server
variable "model_server_instance_type" {
  description = "model server instance type"
  default     = "r5.2xlarge"
}

#name of the model server
variable "model_server_name" {
  description = "model server name"
  default     = "xlrt-model-server"
}

#name of the security group attached to model server 
variable "model_server_security_group" {
  description = "Model server security group"
  default     = "xlrt-model-server-security-group"
}




#--------------------------------------------GRAPH SERVER--------------------------------------------#

#size of the EBS volume to be attached to graph server
variable "ebs_graph_server_size" {
  description = "Total size of the EBS volume for graph server"
  default     = 30
}

#name of the EBS volume attached to graph server
variable "ebs_graph_server_name" {
  description = "Name of the EBS volume for graph server"
  default     = "ebs-xlrt-graph-server"
}

#instance type of the graph server
variable "graph_server_instance_type" {
  description = "graph server instance type"
  default     = "r5a.xlarge"
}

#name of the graph server
variable "graph_server_name" {
  description = "graph server name"
  default     = "xlrt-graph-server"
}

#name of the security group attached to graph server 
variable "graph_server_security_group" {
  description = "Graph server security group"
  default     = "xlrt-graph-server-security-group"
}



#--------------------------------------------NGINX SERVER--------------------------------------------#

#size of the EBS volume to be attached to nginx server
variable "ebs_nginx_server_size" {
  description = "Total size of the EBS volume for nginx server"
  default     = 30
}

#name of the EBS volume attached to nginx server
variable "ebs_nginx_server_name" {
  description = "Name of the EBS volume for nginx server"
  default     = "ebs-xlrt-nginx-server"
}

#instance type of the nginx server
variable "nginx_server_instance_type" {
  description = "nginx server instance type"
  default     = "r5a.large"
}

#name of the nginx server
variable "nginx_server_name" {
  description = "nginx server name"
  default     = "xlrt-nginx-server"
}

#name of the security group attached to nginx server 
variable "nginx_server_security_group" {
  description = "Nginx server security group"
  default     = "xlrt-graph-server-security-group"
}



#--------------------------------------------Vault SERVER--------------------------------------------#

#size of the EBS volume to be attached to vault server
variable "ebs_vault_server_size" {
  description = "Total size of the EBS volume for vault server"
  default     = 16
}

#name of the EBS volume attached to vault server
variable "ebs_vault_server_name" {
  description = "Name of the EBS volume for vault server"
  default     = "ebs-xlrt-vault-server"
}

#instance type of the vault server
variable "vault_server_instance_type" {
  description = "vault server instance type"
  default     = "t3a.large"
}

#name of the vault server
variable "vault_server_name" {
  description = "vault server name"
  default     = "xlrt-vault-server"
}

#name of the security group attached to vault server 
variable "vault_server_security_group" {
  description = "Vault server security group"
  default     = "xlrt-vault-server-security-group"
}



#--------------------------------------------ELK/Monitoring SERVER--------------------------------------------#

#size of the EBS volume to be attached to elk server
variable "ebs_elk_server_size" {
  description = "Total size of the EBS volume for elk server"
  default     = 150
}

#name of the EBS volume attached to elk server
variable "ebs_elk_server_name" {
  description = "Name of the EBS volume for elk server"
  default     = "ebs-xlrt-elk-server"
}

#instance type of the elk server
variable "elk_server_instance_type" {
  description = "elk server instance type"
  default     = "r5a.xlarge"
}

#name of the elk server
variable "elk_server_name" {
  description = "elk server name"
  default     = "xlrt-elk-server"
}

#name of the security group attached to elk server 
variable "elk_server_security_group" {
  description = "ELK server security group"
  default     = "xlrt-elk-server-security-group"
}



#--------------------------------------------Jump SERVER--------------------------------------------#

#size of the EBS volume to be attached to jump server
variable "ebs_jump_server_size" {
  description = "Total size of the EBS volume for jump server"
  default     = 50
}

#name of the EBS volume attached to jump server
variable "ebs_jump_server_name" {
  description = "Name of the EBS volume for jump server"
  default     = "ebs-xlrt-jump-server"
}

#instance type of the jump server
variable "jump_server_instance_type" {
  description = "jump server instance type"
  default     = "t3a.xlarge"
}

#name of the jump server
variable "jump_server_name" {
  description = "jump server name"
  default     = "xlrt-jump-server"
}

#name of the security group attached to jump server 
variable "jump_server_security_group" {
  description = "jump server security group"
  default     = "xlrt-jump-server-security-group"
}