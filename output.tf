# starter code                                  ###################
output "backend_bucket_arn" {
  value = aws_s3_bucket.terraform_state_bucket.arn
}

output "backend_bucket_name" {
  value = aws_s3_bucket.terraform_state_bucket.id
}

output "backend_table_name" {
  value = aws_dynamodb_table.terraform-state-table.id
}

output "kms_key_id" { #you will copy this value that will be returned by terraform to the 'backend.tf' file and use it as the 'kms_key_id' value
  value = aws_kms_key.terraform_backend_key.id
}                                               ##################