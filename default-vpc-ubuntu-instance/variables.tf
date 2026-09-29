variable "ubuntu_ami_id" {
  type        = string
  default     = ""
  description = "The AMI ID is of the Ubuntu AMI to use for the EC2 instance"
}

variable "amazon_ami_id" {
  type        = string
  default     = ""
  description = "The AMI ID is of the Amazon AMI to use for the EC2 instance"
}

variable "rhel_ami_id" {
  type        = string
  default     = ""
  description = "The AMI ID is of the RHEL AMI to use for the EC2 instance"
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
