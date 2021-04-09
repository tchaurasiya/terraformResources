variable "access_key" {}

variable "secret_key" {}


variable "tag" {
  default = "terragrunt-bugbash"
}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region = "us-east-1"
}

resource "aws_instance" "ec2_instance_test" {
  ami           = "ami-0663143d1f1caa3bf"
  instance_type = "t2.nano"
  tags = {
    Name = var.tag
  }
}


terraform {
  backend "s3" {
    # put access_key and secret key from backendconfig file
    # Replace this with your bucket name!
    bucket         = "terraform-state-tathagat-test"
    region         = "us-east-1"
    key = "terraform.tfstate"
    # Replace this with your DynamoDB table name!
    encrypt        = true
  }
}


output "tag" {
  value = var.tag
}
