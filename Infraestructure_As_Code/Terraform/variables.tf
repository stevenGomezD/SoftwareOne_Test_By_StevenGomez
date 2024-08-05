
variable "region" {
  description = "AWS Region"
  type = string
  
}

variable "access_key" {
  description = "Access Key of AWS Account"
  type = string
}

variable "secret_key" {
  description = "Secret Key of AWS Account"
  type = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}
 
variable "key_name" {
  description = "Name of an existing EC2 KeyPair to enable SSH access to the instance"
  type        = string
}
 
variable "windows_instance_ami" {
  description = "AMI ID for the Windows Server instance"
  type        = string
}
 
variable "redhat_instance_ami" {
  description = "AMI ID for the RedHat Server instance"
  type        = string
}
 
variable "ec2_instance_role_name" {
  description = "ARN of EC2 Instance IAM Role"
  type        = string
}
 
variable "vpc_id" {
  description = "VPC ID where the instance will be deployed"
  type        = string
}
 
variable "subnet_id" {
  description = "Subnet ID where the instance will be deployed"
  type        = string
}