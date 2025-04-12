terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  alias   = "accountA"
  region  = "eu-west-1"
  profile = "studygroup-a-terraform"
}