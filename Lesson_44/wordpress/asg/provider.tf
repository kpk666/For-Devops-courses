terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region     = "us-east-2"
  default_tags {
    tags = merge(var.tags, {Environment="${terraform.workspace}"})
  }
}