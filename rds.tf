resource "aws_db_subnet_group" "private_db" {
  name       = "private-db-subnet-group"
  subnet_ids = [aws_subnet.private_db_a.id, aws_subnet.private_db_b.id]
  tags       = { Name = "private-db-subnet-group" }
}

resource "aws_db_instance" "mysql" {
  identifier              = "lab-rds"
  engine                  = "mysql"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  db_name                 = "mydb"
  username                = "admin"
  password                = "StrongPass123!"
  db_subnet_group_name    = aws_db_subnet_group.private_db.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  skip_final_snapshot     = true
  publicly_accessible     = false
  tags = { Name = "mysql-rds" }
}
