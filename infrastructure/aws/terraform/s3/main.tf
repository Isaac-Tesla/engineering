module "bucket_1" {
  source  = "../modules/s3"
  bucket_name = "test-bucket-for-everything"
}