data "terraform_remote_state" "network" {
    backend = "local"

    config = {
        path = "../network/terraform.tfstate.d/${terraform.workspace}/terraform.tfstate"
    }
}

data "aws_availability_zones" "available" {}


#======================================================================

resource "aws_lb" "alb_back" {
  name               = "alb-back"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_asg_SG.id]
  subnets            = data.terraform_remote_state.network.outputs.private_subnets

  enable_deletion_protection = true

}

resource "aws_lb_target_group" "tg_for_back_lb" {
  name     = "tg-for-back-lb"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.network.outputs.vpc_id
}

resource "aws_lb_listener" "back_lb_listener" {
  load_balancer_arn = aws_lb.alb_back.arn
  port              = 80
  protocol          = "HTTP"  
  
  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.tg_for_back_lb.arn}"
  }
}

#==========================================================================

resource "aws_lb" "alb_front" {
  name               = "alb-front"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_asg_SG.id]
  subnets            = data.terraform_remote_state.network.outputs.public_subnets

  enable_deletion_protection = true
 
}

resource "aws_lb_target_group" "tg_for_front_lb" {
  name     = "tg-for-front-lb"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.network.outputs.vpc_id
}

resource "aws_lb_listener" "front_lb_listener" {
  load_balancer_arn = aws_lb.alb_front.arn
  port              = 80
  protocol          = "HTTP"  
  
  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.tg_for_front_lb.arn}"
  }
}

#====================================================================

resource "aws_security_group" "lb_asg_SG" {
  name = "DOS11-student-lb_asg_SG"
  vpc_id = data.terraform_remote_state.network.outputs.vpc_id

  dynamic "ingress" {
    for_each = ["80", "443"]
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

}