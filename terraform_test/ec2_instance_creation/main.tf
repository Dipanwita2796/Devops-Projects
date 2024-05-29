#create the vpc
# resource "aws_vpc" "custom_vpc_creation" {
#   cidr_block = var.vpc_cidr
#   enable_dns_support = true
#   enable_dns_hostnames = true
#   tags = {
#     Name = var.vpc_name
#   }
# }

# # Create Public Subnet
# resource "aws_subnet" "public_subnet_creation" {
#   vpc_id     = aws_vpc.custom_vpc_creation.id
#   cidr_block = var.public_subnet_cidr
#   availability_zone = var.availability_zone  # Update with your desired AZ

#   map_public_ip_on_launch = true

#   tags = {
#     Name = var.public_subnet_name
#   }
# }

# #create the internet gateway
# resource "aws_internet_gateway" "custom_igw_creation" {
#    vpc_id = aws_vpc.custom_vpc_creation.id
#    tags = {
#     Name = var.igw_name
#   }
#  }

# #add the intenet gateway to route table
#  resource "aws_route" "custom_route" {
#   route_table_id         = aws_vpc.custom_vpc_creation.main_route_table_id
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id             = aws_internet_gateway.custom_igw_creation.id
# }

#import the key pair
data "aws_key_pair" "existing_key_pair" {
  key_name = var.key_pair_name
}

#import the iam role
 data "aws_iam_role" "iam_role_access" {
   name = var.role_name
 }


#--------------------------------------------APP SERVER--------------------------------------------#

#app server security group creation
resource "aws_security_group" "app_server_security_group" {
  name        = var.app_server_security_group
  description = "Security group for production app server"

  vpc_id = aws_vpc.custom_vpc_creation.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.app_server_security_group
  }
}

# # Create EBS Volume for app server
resource "aws_ebs_volume" "ebs_volume_app_server" {
  availability_zone = var.availability_zone
  size              = var.ebs_app_server_size
  tags = {
    Name = var.ebs_app_server_name
  }
}

# #create app server ec2 instances
resource "aws_instance" "app_server_creation" {
  ami                  = "ami-0b2ec65899cc867ef" # Amazon Linux 2 AMI
  instance_type        = var.app_server_instance_type
  subnet_id            = aws_subnet.public_subnet_creation.id
  iam_instance_profile = data.aws_iam_role.iam_role_access.name
  key_name = data.aws_key_pair.existing_key_pair.key_name
  security_groups = [aws_security_group.app_server_security_group.id]
  tags = {
    Name = var.app_server_name
  }

}

# #elastic ip attachment with app server ec2 instance
# resource "aws_eip" "ec2_elasticip_app_server" {
#   instance = aws_instance.app_server_creation.id
#   domain   = "vpc"
# }

# # Attach EBS Volume to app server ec2 instance
resource "aws_volume_attachment" "ebs_ec2_attachment_app_server" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.ebs_volume_app_server.id
  instance_id = aws_instance.app_server_creation.id
}




# #--------------------------------------------MODEL SERVER--------------------------------------------#

# #model server security group creation
resource "aws_security_group" "model_server_security_group" {
  name        = var.model_server_security_group
  
  vpc_id = aws_vpc.custom_vpc_creation.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.model_server_security_group
  }
}

# # Create EBS Volume for model server
resource "aws_ebs_volume" "ebs_volume_model_server" {
  availability_zone = var.availability_zone
  size              = var.ebs_model_server_size
  tags = {
    Name = var.ebs_model_server_name
  }
}

# #create app server ec2 instances
resource "aws_instance" "model_server_creation" {
  ami                  = "ami-0b2ec65899cc867ef" # Amazon Linux 2 AMI
  instance_type        = var.model_server_instance_type
  subnet_id            = aws_subnet.public_subnet_creation.id
  iam_instance_profile = data.aws_iam_role.iam_role_access.name
  key_name = data.aws_key_pair.existing_key_pair.key_name
  security_groups = [aws_security_group.model_server_security_group.id]
  tags = {
    Name = var.model_server_name
  }

}

# #elastic ip attachment with app server ec2 instance
# # resource "aws_eip" "ec2_elasticip_model_server" {
# #   instance = aws_instance.model_server_creation.id
# #   domain   = "vpc"
# # }

# # Attach EBS Volume to app server ec2 instance
resource "aws_volume_attachment" "ebs_ec2_attachment_model_server" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.ebs_volume_model_server.id
  instance_id = aws_instance.model_server_creation.id
}




# #--------------------------------------------GRAPH SERVER--------------------------------------------#


# #graph server security group creation
resource "aws_security_group" "graph_server_security_group" {
  name        = var.graph_server_security_group
  
  vpc_id = aws_vpc.custom_vpc_creation.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.graph_server_security_group
  }
}

# # Create EBS Volume for graph server
resource "aws_ebs_volume" "ebs_volume_graph_server" {
  availability_zone = var.availability_zone
  size              = var.ebs_graph_server_size
  tags = {
    Name = var.ebs_graph_server_name
  }
}

# #create graph server ec2 instances
resource "aws_instance" "graph_server_creation" {
  ami                  = "ami-0b2ec65899cc867ef" # Amazon Linux 2 AMI
  instance_type        = var.graph_server_instance_type
  subnet_id            = aws_subnet.public_subnet_creation.id
  iam_instance_profile = data.aws_iam_role.iam_role_access.name
  key_name = data.aws_key_pair.existing_key_pair.key_name
  security_groups = [aws_security_group.graph_server_security_group.id]
  tags = {
    Name = var.graph_server_name
  }

}

# #elastic ip attachment with graph server ec2 instance
# # resource "aws_eip" "ec2_elasticip_graph_server" {
# #   instance = aws_instance.graph_server_creation.id
# #   domain   = "vpc"
# # }

# # Attach EBS Volume to graph server ec2 instance
resource "aws_volume_attachment" "ebs_ec2_attachment_graph_server" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.ebs_volume_graph_server.id
  instance_id = aws_instance.graph_server_creation.id
}



# #--------------------------------------------NGINX SERVER--------------------------------------------#


# #nginx server security group creation
resource "aws_security_group" "nginx_server_security_group" {
  name        = var.nginx_server_security_group
  
  vpc_id = aws_vpc.custom_vpc_creation.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.nginx_server_security_group
  }
}

# # Create EBS Volume for nginx server
resource "aws_ebs_volume" "ebs_volume_nginx_server" {
  availability_zone = var.availability_zone
  size              = var.ebs_nginx_server_size
  tags = {
    Name = var.ebs_nginx_server_name
  }
}

# #create nginx server ec2 instances
resource "aws_instance" "nginx_server_creation" {
  ami                  = "ami-0b2ec65899cc867ef" # Amazon Linux 2 AMI
  instance_type        = var.nginx_server_instance_type
  subnet_id            = aws_subnet.public_subnet_creation.id
  iam_instance_profile = data.aws_iam_role.iam_role_access.name
  key_name = data.aws_key_pair.existing_key_pair.key_name
  security_groups = [aws_security_group.nginx_server_security_group.id]
  tags = {
    Name = var.nginx_server_name
  }

}

# #elastic ip attachment with nginx server ec2 instance
# resource "aws_eip" "ec2_elasticip_nginx_server" {
#   instance = aws_instance.nginx_server_creation.id
#   domain   = "vpc"
# }

# # Attach EBS Volume to nginx server ec2 instance
resource "aws_volume_attachment" "ebs_ec2_attachment_nginx_server" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.ebs_volume_nginx_server.id
  instance_id = aws_instance.nginx_server_creation.id
}





# #--------------------------------------------VAULT SERVER--------------------------------------------#


# #vault server security group creation
resource "aws_security_group" "vault_server_security_group" {
  name        = var.vault_server_security_group
  
  vpc_id = aws_vpc.custom_vpc_creation.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.vault_server_security_group
  }
}

# # Create EBS Volume for vault server
resource "aws_ebs_volume" "ebs_volume_vault_server" {
  availability_zone = var.availability_zone
  size              = var.ebs_vault_server_size
  tags = {
    Name = var.ebs_vault_server_name
  }
}

# #create vault server ec2 instances
resource "aws_instance" "vault_server_creation" {
  ami                  = "ami-0b2ec65899cc867ef" # Amazon Linux 2 AMI
  instance_type        = var.vault_server_instance_type
  subnet_id            = aws_subnet.public_subnet_creation.id
  iam_instance_profile = data.aws_iam_role.iam_role_access.name
  key_name = data.aws_key_pair.existing_key_pair.key_name
  security_groups = [aws_security_group.vault_server_security_group.id]
  tags = {
    Name = var.vault_server_name
  }

}

# #elastic ip attachment with vault server ec2 instance
# # resource "aws_eip" "ec2_elasticip_vault_server" {
# #   instance = aws_instance.vault_server_creation.id
# #   domain   = "vpc"
# # }

# # Attach EBS Volume to vault server ec2 instance
resource "aws_volume_attachment" "ebs_ec2_attachment_vault_server" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.ebs_volume_vault_server.id
  instance_id = aws_instance.vault_server_creation.id
}



# #--------------------------------------------ELK/Monitoring SERVER--------------------------------------------#


# #elk/monitoring server security group creation
resource "aws_security_group" "elk_server_security_group" {
  name        = var.elk_server_security_group
  
  vpc_id = aws_vpc.custom_vpc_creation.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.elk_server_security_group
  }
}

# # Create EBS Volume for elk server
resource "aws_ebs_volume" "ebs_volume_elk_server" {
  availability_zone = var.availability_zone
  size              = var.ebs_elk_server_size
  tags = {
    Name = var.ebs_elk_server_name
  }
}

# #create elk server ec2 instances
resource "aws_instance" "elk_server_creation" {
  ami                  = "ami-0b2ec65899cc867ef" # Amazon Linux 2 AMI
  instance_type        = var.elk_server_instance_type
  subnet_id            = aws_subnet.public_subnet_creation.id
  iam_instance_profile = data.aws_iam_role.iam_role_access.name
  key_name = data.aws_key_pair.existing_key_pair.key_name
  security_groups = [aws_security_group.elk_server_security_group.id]
  tags = {
    Name = var.elk_server_name
  }

}

# #elastic ip attachment with elk server ec2 instance
# # resource "aws_eip" "ec2_elasticip_elk_server" {
# #   instance = aws_instance.elk_server_creation.id
# #   domain   = "vpc"
# # }

# # Attach EBS Volume to elk server ec2 instance
resource "aws_volume_attachment" "ebs_ec2_attachment_elk_server" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.ebs_volume_elk_server.id
  instance_id = aws_instance.elk_server_creation.id
}



#--------------------------------------------Jump SERVER--------------------------------------------#


#jump server security group creation
# resource "aws_security_group" "jump_server_security_group" {
#   name        = var.jump_server_security_group
  
#   vpc_id = aws_vpc.custom_vpc_creation.id

#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = var.jump_server_security_group
#   }
# }

# # Create EBS Volume for jump server
# resource "aws_ebs_volume" "ebs_volume_jump_server" {
#   availability_zone = var.availability_zone
#   size              = var.ebs_jump_server_size
#   tags = {
#     Name = var.ebs_jump_server_name
#   }
# }

# #create jump server ec2 instances
# resource "aws_instance" "jump_server_creation" {
#   ami                  = "ami-0a1b648e2cd533174" # Amazon Linux 2 AMI
#   instance_type        = var.jump_server_instance_type
#   subnet_id            = aws_subnet.public_subnet_creation.id
#   iam_instance_profile = data.aws_iam_role.iam_role_access.name
#   key_name = data.aws_key_pair.existing_key_pair.key_name
#   security_groups = [aws_security_group.jump_server_security_group.id]
#   tags = {
#     Name = var.jump_server_name
#   }

# }

# #elastic ip attachment with jump server ec2 instance
# # resource "aws_eip" "ec2_elasticip_jump_server" {
# #   instance = aws_instance.jump_server_creation.id
# #   domain   = "vpc"
# # }

# # Attach EBS Volume to jump server ec2 instance
# resource "aws_volume_attachment" "ebs_ec2_attachment_jump_server" {
#   device_name = "/dev/sdf"
#   volume_id   = aws_ebs_volume.ebs_volume_jump_server.id
#   instance_id = aws_instance.jump_server_creation.id
# }
