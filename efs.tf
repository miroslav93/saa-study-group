resource "aws_efs_file_system" "foo" {
  provider = aws.accountA
  creation_token = "my-product"

  tags = {
    Name = "MyProduct"
  }
}