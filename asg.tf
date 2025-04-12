# resource "aws_placement_group" "test" {
#   name     = "test"
#   strategy = "cluster"
# }

# resource "aws_launch_template" "sg_lt" {
#   name_prefix   = "foobar"
#   image_id      = "ami-0df368112825f8d8f"
#   instance_type = "t2.micro"
# }

# resource "aws_autoscaling_group" "sg_asg" {
#   name                      = "sg-asg-terraform"
#   max_size                  = 5
#   min_size                  = 2
#   health_check_grace_period = 300
#   health_check_type         = "ELB"
#   desired_capacity          = 3
#   force_delete              = true
# #   placement_group           = aws_placement_group.test.id
#   launch_configuration      = aws_launch_configuration.sg_lt.name
#   vpc_zone_identifier       = [aws_subnet.example1.id, aws_subnet.example2.id]

#   instance_maintenance_policy {
#     min_healthy_percentage = 90
#     max_healthy_percentage = 120
#   }

#   initial_lifecycle_hook {
#     name                 = "foobar"
#     default_result       = "CONTINUE"
#     heartbeat_timeout    = 2000
#     lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"

#     notification_metadata = jsonencode({
#       foo = "bar"
#     })

#     notification_target_arn = "arn:aws:sqs:us-east-1:444455556666:queue1*"
#     role_arn                = "arn:aws:iam::123456789012:role/S3Access"
#   }

#   timeouts {
#     delete = "15m"
#   }

#   tag {
#     key                 = "type"
#     value               = "asg-instance"
#     propagate_at_launch = true
#   }
# }




resource "aws_autoscaling_group" "sg_asg" {
  name                      = "sg-asg"
  min_size                  = 1
  max_size                  = 3
  desired_capacity          = 1
  vpc_zone_identifier      = [aws_subnet.stydygroup_public_subnet.id]
  health_check_type         = "EC2"
  health_check_grace_period = 300
  provider = aws.accountA

  launch_template {
    id      = aws_launch_template.sg_lt.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.test.arn]

  depends_on = [
    aws_lb_target_group.test,
    aws_lb.study_lb,
    aws_launch_template.sg_lt
  ]
}

resource "aws_launch_template" "sg_lt" {
  name_prefix   = "sg-lt-"
  image_id      = "ami-0df368112825f8d8f"
  instance_type = "t3.micro"
  provider = aws.accountA

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.allow_tls.id]
  }
}