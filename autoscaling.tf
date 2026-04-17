
resource "aws_autoscaling_group" "web_asg" {
  name = "lab4-asg"
  desired_capacity = 2
  max_size = 3
  min_size = 1

  vpc_zone_identifier = [aws_subnet.public_a.id, aws_subnet.public_b.id]
  target_group_arns = [aws_lb_target_group.tg.arn]

  launch_template {
    id = aws_launch_template.web_lt.id
    version = "$Latest"
  }

  tag {
    key = "Name"
    value = "lab4-instance"
    propagate_at_launch = true
  }
}

