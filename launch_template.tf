
resource "aws_launch_template" "web_lt" {
  name_prefix   = "lab4-template"
  image_id      = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  user_data = base64encode(<<-EOF
    #!/bin/bash
    yum update -y
    amazon-linux-extras install nginx1 -y
    systemctl enable nginx
    systemctl start nginx
    echo "<h1>Deployed with Auto Scaling + ALB</h1>" > /usr/share/nginx/html/index.html
  EOF
  )
}

