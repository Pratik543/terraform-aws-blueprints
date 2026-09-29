output "ubuntu_instance_public_ip" {
  value = aws_instance.ubuntu.public_ip
}

# output "amazon_instance_public_ip" {
#   value = aws_instance.amazon.public_ip
# }

# output "rhel_instance_public_ip" {
#   value = aws_instance.rhel.public_ip
# }

# ------- SSH Command Outputs for Each Instance-------
output "ubuntu_instance_ssh_command" {
  description = "Example SSH command"
  value       = "ssh -i ${var.key_name}.pem ubuntu@${aws_instance.ubuntu.public_ip}"
}

# output "amazon_instance_ssh_command" {
#   description = "Example SSH command"
#   value       = "ssh -i ${var.key_name}.pem ec2-user@${aws_instance.amazon.public_ip}"
# }

# output "rhel_instance_ssh_command" {
#   description = "Example SSH command"
#   value       = "ssh -i ${var.key_name}.pem ec2-user@${aws_instance.rhel.public_ip}"
# }

# -----------Additional Outputs for Instance Details-----------
# output "ubuntu_instance_all_details" {
#   value = aws_instance.ubuntu
# }

# output "amazon_instance_all_details" {
#   value = aws_instance.amazon
# }

# output "rhel_instance_all_details" {
#   value = aws_instance.rhel
# }
