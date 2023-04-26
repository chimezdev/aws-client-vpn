resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db-subnet-group"
  subnet_ids = ["${element(aws_subnet.private_subnet.*.id, 0)}", "${element(aws_subnet.private_subnet.*.id, 1)}", "${element(aws_subnet.private_subnet.*.id, 2)}"]
}

resource "aws_db_instance" "client-vpn-db" {
  identifier        = "clientvpndb"
  engine            = "postgres"
  engine_version    = "14.6"
  instance_class    = "db.t4g.micro"
  db_name              = "clientvpndb"
  username          = var.db_username
  password          = var.db_password
  allocated_storage = 10
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.priv-sub-sg.id]
  publicly_accessible = false

  tags = {
    Name = "client-db"
  }
}

