variable "vpc_id" {
    type = string
}

variable "subnet_id" {
    type = string
}

variable "sg_allow_ssh_from_bastion" {
    type = string
}

variable "ssh_bastion_host" {
    type = string
}

variable "nginx_wordpress_conf_back_lb" {
    type = string
}