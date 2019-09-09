provider "aws" {
  version = "~> 2.0"
  profile = "prnx-perm"
  region  = "eu-west-1"
}

data "aws_availability_zones" "available" {}