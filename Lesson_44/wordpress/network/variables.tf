variable "cidr_block" {
    type = string
    default = "10.36.0.0/16"
}

variable "common_tags_subnets" {
  description = "tags for subnet resources"
  type = map
  default   = {
    Name    = "Terraform_practice_subnet"
    Owner   = "DOS-11_Student" 
  }
}

variable "common_tags_net" {
  description = "tags for VPC resource"
  type = map
  default   = {
    Name    = "VPC for terraform practice"
    Owner   = "DOS-11_Student" 
  }
}

variable "tags" {
  type    = map
  default = {
    Name = "DOS11_Student"
    Project = "Lesson_44_Practice"
    Terraform = true
  }
}