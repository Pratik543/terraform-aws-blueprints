variable "aws_region" {
  type        = string
  default     = "ap-south-1"
  description = "AWS region to deploy resources in"
}

variable "ubuntu_ami_owners" {
  type        = list(string)
  default     = ["099720109477"]
  description = "Account IDs that own the AMI (Canonical for Ubuntu)"
}

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR block for the new VPC"
}

variable "subnet_cidr" {
  type        = string
  default     = "10.0.1.0/24"
  description = "CIDR block for the public subnet"
}

variable "availability_zone" {
  type        = string
  default     = "ap-south-1a"
  description = "Availability zone for the subnet"
}

variable "project_name" {
  type        = string
  default     = "statusboard"
  description = "Prefix used to name VPC, subnet, and security group resources"
}

variable "key_name" {
  type        = string
  default     = ""
  description = "The key name to use for the EC2 instance"
}

variable "instance_type" {
  type        = string
  default     = "" # 't3.micro'=1GB Mem 't3.small'=2GB Mem 'c7i-flex.large'=4GB Mem 'm7i-flex.large'=8GB Mem
  description = "The instance type to use for the EC2 instance"
}
