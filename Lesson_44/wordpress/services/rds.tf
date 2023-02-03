resource "aws_db_subnet_group" "default" {
  subnet_ids = data.terraform_remote_state.network.outputs.private_subnets
}

resource "aws_security_group" "allow_mysql_access" {
  name        = "allow_mysql"
  description = "allow_mysql"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]    
  }

  tags = {
    Name = "allow_mysql_access"
  }
}

resource "aws_db_instance" "default" {
  identifier = "dos11-wordpress"
  allocated_storage    = 10
  db_name              = "${var.db_name}"
  engine               = "mysql"
  engine_version       = "8.0.30"
  instance_class       = "db.t2.micro"
  username             = "${var.db_user}"
  password             = "${var.db_pass}"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.default.name
  vpc_security_group_ids = [aws_security_group.allow_mysql_access.id]
}