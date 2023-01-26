# Создать конфигурацию

#     vpc
#     subnets: front_net, back_net, db_net в каждой AZ
#     ec2 instances: в каждом из subnets в одной из AZ.
#     Открыть порты к ec2 instances:
#         front: 22, 80, 443 из Internet
#         back: 22, 8080 из front
#         db: 5432 из back, 22 из front
#     Выполнить provisioning машин:
#         back: Nginx в режиме web-сервера с дефолтной страницей
#         front: Nginx в режиме проксирования на Nginx в back

# Критерии:

#     использовать модули
#     параметризировать код
#     возможность развертывания в окружения dev и prod

# module "network" {
#     source = "./network"
# }

data "terraform_remote_state" "network" {
    backend = "local"

    config = {
        path = "network/terraform.tfstate"
    }
}

locals {
  subnet1 = "Front_net"
  subnet2 = "Back_net"
  subnet3 = "database_net"
}

resource "aws_security_group" "Front_net_SG" {
  name = "Front_netSecurityGroup"
  vpc_id = data.terraform_remote_state.network.outputs.vpc_id
  dynamic "ingress" {
    for_each = ["22", "80", "443"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags_sg, {
    name ="${local.subnet1} SecurityGroup"
  })

}

resource "aws_security_group" "Back_net_SG" {
  name = "Back_netSecurityGroup"
  vpc_id = data.terraform_remote_state.network.outputs.vpc_id
  dynamic "ingress" {
    for_each = ["22", "8080"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      security_groups = ["${aws_security_group.Front_net_SG.id}"]
      
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(var.tags_sg, {
    name ="${local.subnet2} SecurityGroup"
  })
}

resource "aws_security_group" "database_net_SG" {
  name = "Database_netSecurityGroup"
  vpc_id = data.terraform_remote_state.network.outputs.vpc_id
  ingress {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      security_groups = ["${aws_security_group.Back_net_SG.id}"]      
    }
  
  ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      security_groups = ["${aws_security_group.Front_net_SG.id}"]      
    }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(var.tags_sg, {
    name ="${local.subnet3} SecurityGroup"
  })
}
