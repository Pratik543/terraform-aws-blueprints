# Create 3 EC2 Instances (Ubuntu, Amazon Linux, RHEL) in the Default VPC
# Fetch the Default VPC
data "aws_vpc" "default" {
  default = true
}

# Fetch the Default Subnets within that VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Fetch the Default Security Group of the VPC
data "aws_security_group" "default" {
  vpc_id = data.aws_vpc.default.id
  name   = "default"
}

# Create an Ubuntu EC2 Instance in the Default VPC
resource "aws_instance" "ubuntu" {
  ami                    = var.ubuntu_ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = data.aws_subnets.default.ids[0]
  vpc_security_group_ids = [data.aws_security_group.default.id]

  tags = {
    Name = "Ubuntu-Instance"
  }

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }
}

# Create an Amazon Linux EC2 Instance in the Default VPC
# resource "aws_instance" "amazon" {
#   ami                    = var.amazon_ami_id
#   instance_type          = var.instance_type
#   key_name               = var.key_name
#   subnet_id              = data.aws_subnets.default.ids[0]
#   vpc_security_group_ids = [data.aws_security_group.default.id]

#   tags = {
#     Name = "Amazon-Linux-Instance"
#   }

#   root_block_device {
#     volume_size = 20
#     volume_type = "gp3"
#   }
# }


# Create a RHEL EC2 Instance in the Default VPC
# resource "aws_instance" "rhel" {
#   ami           = var.rhel_ami_id
#   instance_type = var.instance_type
#   key_name      = var.key_name
#   subnet_id     = data.aws_subnets.default.ids[0]
#   vpc_security_group_ids = [data.aws_security_group.default.id]

#   tags = {
#     Name = "RHEL-Instance"
#   }

#   root_block_device {
#     volume_size = 20
#     volume_type = "gp3"
#   }
# }
