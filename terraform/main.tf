provider "aws" {
  region = var.aws_region
}

#Create security group with firewall rules
resource "aws_security_group" "devToolsCaps" {
  name        = var.sec_grp_name
  description = "security group for DT Capstone"

 ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 # outbound from encore server
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags= {
    Name = "dt-secgp-tag"
  }
}

resource "aws_instance" "devToolsCaps" {
  ami           = "ami-00399ec92321828f5"
  key_name = var.key_name
  instance_type = var.instance_type
  security_groups= [ var.sec_grp_name ]
  tags= {
    Name = var.ec2_name
  }
}

# Create Elastic IP address
resource "aws_eip" "devToolsCaps" {
  vpc      = true
  instance = aws_instance.devToolsCaps.id
tags= {
    Name = "encore_elstic_ip"
  }
}


# Reference this for the following template to create aws ecr
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository
resource "aws_ecr_repository" "devToolsCaps" {
  name                 = var.ecr_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
