resource "aws_s3_bucket" "data_bucket"{
  bucket = "project-bucket-for-everything-raw"
  acl    = "private"

  versioning {
    enabled = "false"
  }
}

resource "aws_s3_bucket" "data_bucket_staging"{
  bucket = "project-bucket-for-everything-staging"
  acl    = "private"

  versioning {
    enabled = "false"
  }
}