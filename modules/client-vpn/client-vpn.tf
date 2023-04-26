resource "aws_ec2_client_vpn_endpoint" "client-vpn" {
  description            = "provision client vpn endpoint"
  server_certificate_arn = var.certificate_arn         # provide the certificate arn that was returned when u created and uploaded the certificates to acm
  client_cidr_block      = "10.2.0.0/22"              # this should be btw /12 to /22 and it must not overlap with the vpc that will be associated with the client vpn
  split_tunnel = true

  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = var.certificate_arn
  }

  connection_log_options {
    enabled               = true
    cloudwatch_log_group  = aws_cloudwatch_log_group.vpn_lg.name
    cloudwatch_log_stream = aws_cloudwatch_log_stream.vpn_ls.name
  }
}

resource "aws_cloudwatch_log_group" "vpn_lg" {
  name = "client-vpn-grp"
}

resource "aws_cloudwatch_log_stream" "vpn_ls" {
  name           = "client-vpn-strm"
  log_group_name = "${aws_cloudwatch_log_group.vpn_lg.name}"
}

resource "aws_ec2_client_vpn_network_association" "vpn-subnet-assoc" {
  client_vpn_endpoint_id = "${aws_ec2_client_vpn_endpoint.client-vpn.id}"
  count         = var.private-subnet
  subnet_id     = "${element(aws_subnet.private_subnet.*.id, count.index)}"
  lifecycle {
    ignore_changes = [subnet_id] # I don't know why it tries to change this every time
  }
}

resource "aws_ec2_client_vpn_authorization_rule" "vpn_auth_rule" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.client-vpn.id
  target_network_cidr = aws_vpc.client_vpn_vpc.cidr_block
  authorize_all_groups = true
}