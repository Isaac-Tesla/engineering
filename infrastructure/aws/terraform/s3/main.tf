module "bucket_1" {
  source  = "../_modules/s3"
  bucket_name = "test-bucket-for-everything"
}