# this calls the client-vpn module located at ./modules/client-vpn
module "client_vpn" {
  source = "./modules/client-vpn"
  certificate_arn = var.certificate_arn
  db_username = var.db_username
  db_password = var.db_password
  pri_cidrs = var.pri_cidrs
}