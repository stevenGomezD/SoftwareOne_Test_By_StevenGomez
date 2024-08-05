terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}
 
resource "aws_security_group" "windows_instance_sg" {
  name        = "windows_instance_sg"
  description = "Security Group of Windows Instance"
  vpc_id      = var.vpc_id
 
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  ingress {
    from_port   = 1433
    to_port     = 1433
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
 
resource "aws_security_group" "linux_instance_sg" {
  name        = "linux_instance_sg"
  description = "Security Group of Linux Instance"
  vpc_id      = var.vpc_id
 
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
 
resource "aws_instance" "windows_ec2_instance" {
  ami                         = var.windows_instance_ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id
  disable_api_termination     = true
security_groups = [aws_security_group.windows_instance_sg.name]
 
  user_data = <<-EOF
  <powershell>
  #
  </powershell>
  EOF
}
 
resource "aws_instance" "redhat_ec2_instance_1" {
  ami                         = var.redhat_instance_ami
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  disable_api_termination     = true
  security_groups = [aws_security_group.linux_instance_sg.name]
  iam_instance_profile        = var.ec2_instance_role_name
 
  user_data = <<-EOF
  #!/bin/bash
  EOF
}
 
resource "aws_instance" "redhat_ec2_instance_2" {
  ami                         = var.redhat_instance_ami
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  disable_api_termination     = true
  security_groups = [aws_security_group.linux_instance_sg.name]
  iam_instance_profile        = var.ec2_instance_role_name
 
  user_data = <<-EOF
  #!/bin/bash
  EOF
}