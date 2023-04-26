output "db_connection_endpoint" {
  value = aws_db_instance.client-vpn-db.endpoint
}

output "subnet_ids_a" {
  value = element(aws_subnet.private_subnet.*.id, 0)
}

output "subnet_ids_b" {
  value = element(aws_subnet.private_subnet.*.id, 1)
}

output "subnet_ids_c" {
  value = element(aws_subnet.private_subnet.*.id, 2)
}
