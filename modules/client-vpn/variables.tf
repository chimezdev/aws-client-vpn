variable "certificate_arn" {}

variable "db_username" {}

variable "db_password" {}

variable "pri_cidrs" {}

variable "public-subnet" {
  default = "3"
}

variable "private-subnet" {
  default = "3"
}

variable "pub_cidrs" {
  default = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
}

# default = "${env.CERT_ARN}"
# default = "${env.db_user}"
# default = "${env.db_pass}"
