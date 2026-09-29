# Create an Ubuntu Ansible control node (master) and a configurable number of Ubuntu
# Ansible worker instances in the Default VPC
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

# Create an Ubuntu Ansible Master EC2 Instance in the Default VPC
resource "aws_instance" "ubuntu_ansible_master" {
  ami                    = var.ubuntu_ansible_master_ami_id
  instance_type          = var.ubuntu_ansible_master_instance_type
  key_name               = var.key_name
  subnet_id              = data.aws_subnets.default.ids[0]
  vpc_security_group_ids = [data.aws_security_group.default.id]

  tags = {
    Name = "Ubuntu-Ansible-Master"
  }

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }
}

resource "aws_instance" "ubuntu_ansible_worker" {
  ami                    = var.ubuntu_ansible_worker_ami_id
  instance_type          = var.ubuntu_ansible_worker_instance_type
  key_name               = var.key_name
  subnet_id              = data.aws_subnets.default.ids[0]
  vpc_security_group_ids = [data.aws_security_group.default.id]
  count                  = var.ansible_worker_count

  tags = {
    Name        = format("Ubuntu-Ansible-Worker-%02d", count.index + 1)
    Environment = "dev"
  }

  root_block_device {
    volume_size = 15
    volume_type = "gp3"
  }
}


