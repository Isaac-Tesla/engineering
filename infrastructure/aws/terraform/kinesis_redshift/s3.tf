resource "aws_s3_bucket" "bucket"{
  bucket = "kinesis-bucket-for-testing"
  acl    = "private"

  versioning {
    enabled = "false"
  }
}