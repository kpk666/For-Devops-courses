# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 4.16"
#     }
#   }

#   required_version = ">= 1.2.0"
# }

# provider "aws" {
#     region     = "us-east-2"
# }

terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region     = "us-east-2"
  default_tags {
    tags = merge(var.tags, {Environment="${terraform.workspace}"})
  }
}