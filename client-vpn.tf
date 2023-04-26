module "client_vpn" {
  source = "./modules/client-vpn"
  certificate_arn = var.certificate_arn
  db_username = var.db_username
  db_password = var.db_password
  pri_cidrs = var.pri_cidrs
}