# starter code                                                          ###################
provider "aws" {
    region = "us-east-1"
}

# comment out this terraform block before running you first terraform init
terraform {
    required_providers {
        aws = {
        source = "hashicorp/aws"
        version = ">= 4.48.0"        #version is optional, u can remove this line
        }
    }
    

    backend "s3" {
        bucket         = "client-vpn-terraform-state-bucket"
        key            = "client-vpn/terraform.tfstate"
        region         = "us-east-1"
        dynamodb_table = "terraform-state-table"
        encrypt        = true
        profile        = "default"
        kms_key_id     = "22ac196a-e1ab-4acb-81e9-c87c68f431d5"
    }
}     # uncomment the 'terraform' block above and run `terraform init` again to migrate your remotestate to the s3 that was created.
                                                                        ##################