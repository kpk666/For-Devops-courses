variable "cidr_block" {
    type = string
    default = "10.10.0.0/16"
}

variable "common_tags_subnets" {
  description = "tags for all resources"
  type = map
  default   = {
    Name    = "Terraform_practice_subnet"
    Owner   = "DOS-11_Student" 
  }
}