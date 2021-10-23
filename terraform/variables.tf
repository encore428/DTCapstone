variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-east-2"
}

variable "key_name" {
  description = "SSH keys to connect to ec2 instance"
  default     =  "AWS-encore-MBP"
}

variable "instance_type" {
  description = "instance type for ec2"
  default     =  "t2.micro"
}

variable "ecr_name" {
  description = "EC repository name"
  default     =  "dt-ecr-1"
}

variable "ec2_name" {
  description = "ec2 instance name"
  default     =  "dt-ecs-1"
}

variable "sec_grp_name" {
  description = "security group name"
  default     =  "dt-secgp-1"
}
