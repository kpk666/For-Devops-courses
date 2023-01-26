variable "tags_sg" {
    description = "tags for all resources"
    type = map
    default   = {    
    Owner   = "DOS-11_Student" 
  }
}

variable "ami_name" {
  default = "data.aws_ami.latest_ubuntu.id"
}

variable "cidr_block" {
    type = string
    default = "10.10.0.0/16"
}