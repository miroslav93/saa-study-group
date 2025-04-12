resource "aws_vpc" "stydygroup_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  provider = aws.accountA

  tags = {
    Name = "stydygroup_vpc"
    createdBy = "Terraform"
    env = "dev"
  }
}

resource "aws_subnet" "stydygroup_public_subnet" {
  vpc_id     = aws_vpc.stydygroup_vpc.id
  cidr_block = "10.0.0.0/20"
  availability_zone = "eu-west-1a"

  provider = aws.accountA


  tags = {
    Name = "stydygroup_public_subnet"
    createdBy = "Terraform"
    env = "dev"
  }

  depends_on = [aws_vpc.stydygroup_vpc]
}

resource "aws_subnet" "stydygroup_public_subnet-2" {
  vpc_id     = aws_vpc.stydygroup_vpc.id
  cidr_block = "10.0.16.0/20"
  availability_zone = "eu-west-1b"

  provider = aws.accountA


  tags = {
    Name = "stydygroup_public_subnet-2"
    createdBy = "Terraform"
    env = "dev"
  }

  depends_on = [aws_vpc.stydygroup_vpc]
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.stydygroup_vpc.id

  provider = aws.accountA


  tags = {
    Name = "igw"
    createdBy = "Terraform"
    env = "dev"
  }
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.stydygroup_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  provider = aws.accountA


  tags = {
    Name = "public-rt"
    createdBy = "Terraform"
    env = "dev"
  }
}

