terraform {

  # backend "s3" {
  #   bucket = "terraform-proj-mb"
  #   key    = "terraform-state"
  #   region = "ap-south-1"
  # }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.46.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"

}

