resource "aws_s3_bucket" "example" {
  provider = aws.accountA
  bucket = "my-tf-test-bucket-sgbl-25"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}