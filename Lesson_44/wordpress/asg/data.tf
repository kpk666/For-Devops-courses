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

data "aws_lb_target_group" "front_targetgroup" {
  name = "tg-for-front-lb"
}

data "aws_lb_target_group" "back_targetgroup" {
  name = "tg-for-back-lb"
}