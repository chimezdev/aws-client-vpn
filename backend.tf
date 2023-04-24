provider "aws" {
    region = "us-east-1"
}


# terraform {
    # required_providers {
#     aws = {
#     source = "hashicorp/aws"
#     version = ">= 4.48.0"        #version is optional, u can remove this line
#     }
# }
    

#     backend "s3" {
#         bucket         = "client-vpn-terraform-state-bucket"
#         key            = "client-vpn/terraform.tfstate"
#         region         = "us-east-1"
#         dynamodb_table = "terraform-state-table"
#         encrypt        = true
#         profile        = "default"
#         #kms_key_id     = "8b734e29-9951-43dd-a85d-b6f986554558"
#     }
# }
