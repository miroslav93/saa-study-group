resource "aws_instance" "studygroup" {
  ami           = "ami-0df368112825f8d8f"
  instance_type = "t3.micro"
  provider = aws.accountA
  subnet_id     = aws_subnet.stydygroup_public_subnet.id

  tags = {
    Name = "Studygroup"
    createdBy = "Terraform"
    env = "dev"
  }
}

