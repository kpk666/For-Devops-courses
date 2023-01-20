# создать в тераформе инфраструктуру на базе 2 сг 
# (фронт и бэк) и 3 инстансов (1 фронт и 2 бэка).
# Фронт сг должна разрешать доступ по 22, 80 и 443 портам для всего мира, бэк сг по 22 и 8080 портам для сг фронта.
# Желательно делать сразу разбиение компонентов (переменные, выводы, провайдер и ресурсы)
# на отдельные файлы и использовать минимум хардкода в описании ресурсов, таких как инстансы.
# Будет плюсом настроить мапинг ами ид для инстансов.

resource "aws_security_group" "FrontSecurityGroup" {
  name = "FrontSecurityGroup"

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

  tags = {
    Name  = "FrontSecurityGroup"
    Owner = "DOS-11 Student"
  }
}

resource "aws_security_group" "BackEndSecurityGroup" {
  name = "BackEndSecurityGroup"

  dynamic "ingress" {
    for_each = ["22", "8080"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      security_groups = ["${aws_security_group.FrontSecurityGroup.id}"]
      
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "BackEndSecurityGroup"
    Owner = "DOS-11 Student"
  }
}

