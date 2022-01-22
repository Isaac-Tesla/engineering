resource "google_storage_bucket" "staging_bucket" {
  name          = "dataproc-staging-bucket"
  location      = var.region
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 3
    }
    action {
      type = "Delete"
    }
  }
}