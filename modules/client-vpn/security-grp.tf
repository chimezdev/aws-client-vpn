resource "aws_security_group" "client-vpn-sg" {
  name        = "client_vpn_sg"
  vpc_id      = aws_vpc.client_vpn_vpc.id

  ingress {
    from_port     = 0
    to_port       = 0
    protocol      = "-1"
    cidr_blocks = ["102.89.34.147/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "priv-sub-sg" {
  name        = "private_subnet_security_group"
  vpc_id      = aws_vpc.client_vpn_vpc.id

  ingress {
    from_port     = 5432
    to_port       = 5432
    protocol      = "tcp"
    security_groups = ["${aws_security_group.client-vpn-sg.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}