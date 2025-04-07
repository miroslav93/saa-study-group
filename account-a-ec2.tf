resource "aws_instance" "studygroup" {
  ami           = "ami-084568db4383264d4"
  instance_type = "t3.micro"
  provider = aws.accountA
  subnet_id     = aws_subnet.stydygroup_public_subnet.id

  tags = {
    Name = "Studygroup"
    createdBy = "Terraform"
    env = "dev"
  }
}

resource "aws_lb" "study_lb" {
  name               = "study-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_tls.id]
  subnets            = [aws_subnet.stydygroup_public_subnet.id, aws_subnet.stydygroup_public_subnet-2.id]
  provider = aws.accountA


  enable_deletion_protection = true

  tags = {
    Environment = "production"
  }

  depends_on = [
    aws_security_group.allow_tls,
    aws_subnet.stydygroup_public_subnet,
    aws_subnet.stydygroup_public_subnet-2
  ]
}

resource "aws_lb_listener" "study_lb_listener" {
  load_balancer_arn = aws_lb.study_lb.arn
  port              = 80
  protocol          = "HTTP"
  provider          = aws.accountA

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.arn
  }
}


resource "aws_lb_target_group" "test" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.stydygroup_vpc.id
  provider = aws.accountA
}

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.test.arn
  target_id        = aws_instance.studygroup.id
  port             = 80
  provider = aws.accountA
}