resource "aws_s3_bucket" "devops_data_bucket_staging"{
  bucket = "eks-project-bucket-for-everything"
  acl    = "private"

  versioning {
    enabled = "false"
  }
}