resource "aws_iam_user" "dp" {
  name = "dusan.plavsic"
  path = "/"

  tags = {
    Name = "dusan.plavsic"
    createdBy = "Terraform"
    env = "dev"
  }
}

resource "aws_iam_user" "db" {
  name = "dejan.babic"
  path = "/"

  tags = {
    Name = "dejan.babic"
    createdBy = "Terraform"
    env = "dev"
  }
}

resource "aws_iam_access_key" "dp_key" {
  user = aws_iam_user.dp.name
}

resource "aws_iam_access_key" "db_key" {
  user = aws_iam_user.db.name
}

resource "aws_iam_group" "devops" {
  name = "DevOpsv2"
  path = "/users/"
}

resource "aws_iam_group_membership" "team" {
  name = "devops-group-membership"

  users = [
    aws_iam_user.dp.name,
    aws_iam_user.db.name,
  ]

  group = aws_iam_group.devops.name
  
}

resource "aws_iam_policy" "read_ec2" {
  name        = "test_policy"
  path        = "/"
  description = "My test policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
  tags = {
    createdBy = "Terraform"
    env = "dev"
  }
}

resource "aws_iam_group_policy_attachment" "test-attach" {
  group      = aws_iam_group.devops.name
  policy_arn = aws_iam_policy.read_ec2.arn
}