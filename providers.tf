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

provider "aws" {
  alias   = "accountA-us-east-1"
  region  = "us-east-1"
  profile = "studygroup-a-terraform"
}