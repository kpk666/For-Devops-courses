output "front_for_lb" {
  value = data.aws_lb_target_group.front_targetgroup.arn
}

output "back_for_lb" {
  value = data.aws_lb_target_group.back_targetgroup.arn
}