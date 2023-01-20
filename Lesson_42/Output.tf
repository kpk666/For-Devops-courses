output "Front_Instance_id" {
  value = aws_instance.Front_Instance.id
}

output "Front_Instance_ami" {
  value = aws_instance.Front_Instance.ami
}

output "BackEnd_Instance_1_id" {
  value = aws_instance.BackEnd_Instance_1.id
}

output "BackEnd_Instance_2_id" {
  value = aws_instance.BackEnd_Instance_2.id
}

output "BackEnd_Instance_1_ami" {
  value = aws_instance.BackEnd_Instance_1.ami
}

output "BackEnd_Instance_2_ami" {
  value = aws_instance.BackEnd_Instance_2.ami
}