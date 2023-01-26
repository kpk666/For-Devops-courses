data "aws_availability_zones" "available_instance" {}

data "aws_ami" "latest_ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_key_pair" "acces_key" {
  key_name = "Astrovskiy-key"
}

resource "aws_instance" "public_instance" {
  
  ami                         = data.aws_ami.latest_ubuntu.id
  key_name                    = data.aws_key_pair.acces_key.key_name
  instance_type               = "t2.micro"
  subnet_id                   = data.terraform_remote_state.network.outputs.public_subnets[0]
  associate_public_ip_address = true
  security_groups             = [aws_security_group.Front_net_SG.id]
  availability_zone           = data.aws_availability_zones.available_instance.names[0]

  tags = merge(var.tags_sg, {
    name    = "public_instance_test"    
  })
  user_data = file("user_data_front.sh")

  #  connection {
  #   type     = "ssh"
  #   user     = "ubuntu"
  #   private_key = file("Astrovskiy-key.pem")
  #   host     = self.public_ip
  # }  

  #  provisioner "file" {
  #   source      = "default.sh"
  #   destination = "/tmp/default.sh"
  # }
  
  
  # provisioner "remote-exec" {
  #   inline = [
  #     "sudo chmod +x /tmp/script.sh",
  #     "sudo /tmp/default.sh args",
  #   ]
      
  # }
}

resource "aws_instance" "private_instance" {
  
  ami                         = data.aws_ami.latest_ubuntu.id
  key_name                    = data.aws_key_pair.acces_key.key_name
  instance_type               = "t2.micro"
  subnet_id                   = data.terraform_remote_state.network.outputs.private_subnets[0]
  associate_public_ip_address = true
  security_groups             = [aws_security_group.Back_net_SG.id]
  availability_zone           = data.aws_availability_zones.available_instance.names[0]
  tags = merge(var.tags_sg, {
    name    = "private_instance_test"    
  })
  user_data = file("user_data_back.sh")
  
}

resource "aws_instance" "database_instance" {
  
  ami                         = data.aws_ami.latest_ubuntu.id
  key_name                    = data.aws_key_pair.acces_key.key_name
  instance_type               = "t2.micro"
  subnet_id                   = data.terraform_remote_state.network.outputs.database_subnets[0]
  associate_public_ip_address = false
  security_groups             = [aws_security_group.database_net_SG.id]
  availability_zone           = data.aws_availability_zones.available_instance.names[0]
  tags = merge(var.tags_sg, {
    name   = "database_instance_test"    
  })
}

output "private_instance_ip" {
  value = aws_instance.private_instance.public_ip
}