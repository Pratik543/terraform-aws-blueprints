# ----------- Networking Outputs -----------
output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.main.id
}

output "subnet_id" {
  description = "ID of the created public subnet"
  value       = aws_subnet.public.id
}

output "security_group_id" {
  description = "ID of the default security group"
  value       = aws_default_security_group.default.id
}

# ----------- Instance Outputs -----------
output "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.host.public_ip
}

output "ec2_elastic_ip" {
  description = "Elastic IP of the EC2 instance"
  value       = aws_eip.host.public_ip
}

output "ubuntu_instance_ami" {
  description = "AMI ID selected by the filter"
  value       = data.aws_ami.ubuntu.id
}

# ------- SSH Command Output -------
output "ec2_ssh_command" {
  description = "Example SSH command for the EC2 instance"
  value       = "ssh -i ~/.ssh/${var.key_name}.pem ubuntu@${aws_eip.host.public_ip}"
}
