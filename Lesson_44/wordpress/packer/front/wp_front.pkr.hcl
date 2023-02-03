packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "dos11-student-wordpress-front"
  instance_type = "t2.micro"
  region        = "us-east-2"
  # profile       = ""
  tags          = {
    Name = "dos11-student-wordpress-front"
  }

  vpc_id  = "${var.vpc_id}"
  subnet_id = "${var.subnet_id}"
  security_group_id = "${var.sg_allow_ssh_from_bastion}"
  ssh_bastion_host = "${var.ssh_bastion_host}"
  ssh_bastion_username = "ubuntu"
  ssh_bastion_private_key_file = "/mnt/d/Terraform/Astr-key.pem"
  # ssh_bastion_agent_auth = true
  ssh_username = "ubuntu"

  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-focal-20.04-amd64-server*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
}

build {
    sources = [
        "source.amazon-ebs.ubuntu"
    ]

    provisioner "ansible" {
        playbook_file = "../ansible/playbooks/wp_front.yaml"
        extra_arguments = ["--extra-vars", "nginx_wordpress_conf_back_lb=${var.nginx_wordpress_conf_back_lb}"]
    }
}