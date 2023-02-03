resource "aws_launch_template" "front_template" {
  name_prefix   = "front-template-"
  image_id      = "ami-0c8deb6ad477cf130"
  instance_type = "t2.micro"
}

resource "aws_launch_template" "back_template" {
  name_prefix   = "back-template-"
  image_id      = "ami-0d4d5fe08321c3496"
  instance_type = "t2.micro"
}

resource "aws_autoscaling_group" "AutoScellingGroup_public" {
  
  name                 = "DOS11_asg_public"  
  max_size             = 2
  min_size             = 1
  min_elb_capacity     = 1
  health_check_type    = "ELB"
  vpc_zone_identifier  = data.terraform_remote_state.network.outputs.public_subnets
  wait_for_capacity_timeout = 0
  launch_template {
    id      = aws_launch_template.front_template.id
  }
    target_group_arns = [ data.aws_lb_target_group.front_targetgroup.arn ]
  
}

resource "aws_autoscaling_group" "AutoScellingGroup_private" {
  
  name                 = "DOS11_asg_private"  
  max_size             = 2
  min_size             = 1
  min_elb_capacity     = 1
  health_check_type    = "ELB"
  vpc_zone_identifier  = data.terraform_remote_state.network.outputs.private_subnets
  wait_for_capacity_timeout = 0
   launch_template {
    id      = aws_launch_template.back_template.id
  }
    target_group_arns = [ data.aws_lb_target_group.back_targetgroup.arn ]
  
}
