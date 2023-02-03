resource "aws_launch_template" "front_template" {
  name = "ec2_instance_from_front_template"
  image_id = "ami-0c8deb6ad477cf130"
  instance_initiated_shutdown_behavior = "terminate"
  instance_type = "t2.micro"
  key_name = data.aws_key_pair.selected.key_name
#   placement {
#     availability_zone = data.aws_availability_zones.available.id[0]
#   }
  vpc_security_group_ids = [data.aws_security_group.SSH_bastion_access.id]
}

resource "aws_launch_template" "back_template" {
  name = "ec2_instance_from_back_template"
  image_id = "ami-0d4d5fe08321c3496"
  instance_initiated_shutdown_behavior = "terminate"
  instance_type = "t2.micro"
  key_name = data.aws_key_pair.selected.key_name
#   placement {
#     availability_zone = data.aws_availability_zones.available.id[1]
#   }
  vpc_security_group_ids = [data.aws_security_group.SSH_bastion_access.id]
}

#============================================================

output "sec_group_for_ssh" {
  value = data.aws_security_group.SSH_bastion_access.id
}