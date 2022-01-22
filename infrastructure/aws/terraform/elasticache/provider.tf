provider "aws" {
  region = var.region
  shared_credentials_file = "~/.aws/credentials"
  profile = "default"
}

terraform {
  backend "s3" {
    bucket = ""
    key    = "statefile/elastic/terraform_elasticache.tfstate"
    region = "ap-southeast-2"
  }
}