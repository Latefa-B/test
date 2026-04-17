resource "aws_instance" "app" {
  ami                         = "ami-0c02fb55956c7d316"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.private_app.id
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.app_sg.id]
  key_name                    = "new-key"
  tags = { Name = "app-tier" }

  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y httpd
    echo "Hello from the private app tier" > /var/www/html/index.html
    sudo systemctl start httpd
    sudo systemctl enable httpd
  EOF
}
