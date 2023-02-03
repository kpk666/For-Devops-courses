
output "bastion_ip" {
  value = aws_instance.Bastion.public_ip
}