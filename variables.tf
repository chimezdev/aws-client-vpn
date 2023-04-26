# STARTER CODE                                              ########################
# create default bucket and dynamodb names as variables
variable "bucket_name" {
  type    = string
  default = "client-vpn-terraform-state-bucket"
}

variable "dynamodb_table_name" {
  type    = string
  default = "terraform-state-table"
}                                                           ########################

variable "certificate_arn" {}

variable "db_username" {}

variable "db_password" {}

variable "pri_cidrs" {}