resource "aws_db_instance" "sql_db" {
  identifier           = "sql-database"
  engine               = "sqlserver-ex"
  instance_class       = "db.t3.medium"
  allocated_storage    = 20
  username             = var.db_username
  password             = var.db_password
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name = aws_db_subnet_group.private.name
}

resource "aws_db_subnet_group" "private" {
  name       = "private-db-subnet"
  subnet_ids = var.private_subnets
}
