variable "access_key" {}

variable "secret_key" {}


variable "tag" {
  default = "tathagat-test-1"
}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region = "us-east-1"
}

resource "aws_instance" "ec2_instance_test" {
  ami           = "ami-0663143d1f1caa3bf"
  instance_type = "t2.micro"
  tags = {
    Name = var.tag
  }
}

resource "aws_s3_bucket" "terraform_state_tathagat_test" {
  bucket = "terraform-state-tathagat-test"
  # Enable versioning so we can see the full revision history of our
  # state files
  versioning {
    enabled = true
  }
  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

terraform {
  backend "s3" {
    access_key = var.access_key
    secret_key = var.secret_key
    # Replace this with your bucket name!
    bucket         = "terraform-state-tathagat-test"
    region         = "us-east-1"
    key = "terraform.tfstate"
    # Replace this with your DynamoDB table name!
    encrypt        = true
  }
}


data "aws_iam_policy_document" "tf_backend_bucket_policy" {
  statement {
    sid    = "RequireEncryptedTransport"
    effect = "Deny"
    actions = [
      "s3:*",
    ]
    resources = [
      "${aws_s3_bucket.terraform_state_tathagat_test.arn}/*",
    ]
    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values = [
        false,
      ]
    }
    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }

  statement {
    sid    = "RequireEncryptedStorage"
    effect = "Deny"
    actions = [
      "s3:PutObject",
    ]
    resources = [
      "${aws_s3_bucket.terraform_state_tathagat_test.arn}/*",
    ]
    condition {
      test     = "StringNotEquals"
      variable = "s3:x-amz-server-side-encryption"
      values = ["AES256"]
    }
    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket_policy" "tf_backend_bucket_policy" {
  bucket = aws_s3_bucket.terraform_state_tathagat_test.id
  policy = data.aws_iam_policy_document.tf_backend_bucket_policy.json
}

output "tag" {
  value = var.tag
}