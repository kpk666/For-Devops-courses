variable "tags" {
  type    = map
  default = {
    Name = "DOS11_Student"
    Project = "Lesson_44_Practice"
    Terraform = true
  }
}

variable "db_name" {
  type = string
  default = "wordpress"
}

variable "db_pass" {
  type = string
  default = "wordpress"
 
}

variable "db_user" {
  type = string
  default = "wordpress"
}