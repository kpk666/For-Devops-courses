data "terraform_remote_state" "network" {
    backend = "local"

    config = {
        path = "../network/terraform.tfstate.d/${terraform.workspace}/terraform.tfstate"
    }
}

data "aws_availability_zones" "available" {}

data "aws_key_pair" "selected" {
  key_name = "Astr-key"
}

data "aws_security_group" "SSH_bastion_access" {
  tags = {
    Name = "SSH_bastion_access"    
  }
}

