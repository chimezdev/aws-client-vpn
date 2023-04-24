# STARTER CODE                                                          ########################
# creates kms key that will be used to encrypt the state files
resource "aws_kms_key" "terraform_backend_key" {
  description             = "KMS key for encrypting Terraform remote state files"
  enable_key_rotation     = true
  deletion_window_in_days = 30

  tags = {
    Name = "terraform-remote-backend-key"
  }
}

# creates s3 bucket resource that will be used as the remote backend with encryption enabled
resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = var.bucket_name
  acl    = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.terraform_backend_key.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name = "terraform-remote-backend-bucket"
  }
}

resource "aws_s3_bucket_public_access_block" "terraform_state_bucket" {
  bucket = aws_s3_bucket.terraform_state_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# creates the dynamodb table for locking
resource "aws_dynamodb_table" "terraform-state-table" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "terraform-remote-backend-table"
  }
}                                                                         ########################