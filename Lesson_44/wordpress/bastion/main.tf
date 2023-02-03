data "terraform_remote_state" "network" {
    backend = "local"

    config = {
        path = "../network/terraform.tfstate.d/${terraform.workspace}/terraform.tfstate"
    }
}

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
  owners = ["099720109477"]
}

data "aws_key_pair" "selected" {
  key_name = "Astr-key"
}

resource "aws_security_group" "ssh_access_SecGroup" {
  name        = "allow_ssh_common"
  description = "open access to 22 port"
  vpc_id = data.terraform_remote_state.network.outputs.vpc_id
    
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }  
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]    
  }

  tags = {
    Name = "SSH_access"
  }
}

resource "aws_security_group" "ssh_bastion_SecGroup" {
  name        = "allow_ssh_from_bastion"
  description = "open access from bastion"
  vpc_id = data.terraform_remote_state.network.outputs.vpc_id
    
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [ aws_security_group.ssh_access_SecGroup.id ]
  }  
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]    
  }

  tags = {
    Name = "SSH_bastion_access"
  }
}

resource "aws_instance" "Bastion" { 
  ami                         = data.aws_ami.latest_ubuntu.id
  instance_type               = "t2.micro"
  key_name                    = data.aws_key_pair.selected.key_name
  subnet_id                   = data.terraform_remote_state.network.outputs.public_subnets[0]
  security_groups             = [aws_security_group.ssh_access_SecGroup.id]
  associate_public_ip_address = true

  tags = {
    Name = "Bastion_Instance_DOS-11_practice"
  }
}
