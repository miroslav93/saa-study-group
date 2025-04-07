terraform {
  backend "s3" {
    bucket = "saa-studygroup-bl-s3"
    key    = "terraform.tfstate"
    region = "us-east-1"
    profile = "studygroup-a-terraform"
  }
}