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

# terraform {
#   backend "s3" {
#       bucket = "terrafom-bucket"
#       key = "path/to/key"
#       region = "us-east-1"
#   }

#   required_providers {
#     aws = {
#       source = "hashicorp/aws"
#       version = "4.22.1"
#     }
#   }

#   provider "aws" {
#     region = "us-east-1"
#   }
# }